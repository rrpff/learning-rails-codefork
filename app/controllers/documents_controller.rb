class DocumentsController < ApplicationController

    before_action :authenticate_user!,
        except: [:index, :show]

    around_filter :catch_record_not_found

    def new
        @document = Document.new
    end

    def edit
        @document = Document.find params[:id]

        if not user_has_permission_to_modify?(@document)
            redirect_to @document, flash: { error: 'You don\'t have permission to edit this document.' }
        end
    end

    def show
        @document = Document.find params[:id]
    end

    def create
        @document = Document.new document_params
        @document.user = current_user

        if @document.save
            redirect_to @document, flash: { success: "#{@document.name} created!" }
        else
            render 'new'
        end
    end

    def update
        @document = Document.find params[:id]

        if user_has_permission_to_modify?(@document) and @document.update document_params
            redirect_to @document, flash: { success: "#{@document.name} saved!" }
        else
            render 'edit'
        end
    end

    def destroy
        @document = Document.find params[:id]

        if user_has_permission_to_modify?(@document)
            @document.destroy
            redirect_to 'index'
        else
            render 'show', flash: { error: 'You don\'t have permission to delete this document.' }
        end

    end

    def fork
        @parent = Document.find params[:id]
        @document = clone_and_reassign_document @parent

        if @document.update forked: true, forked_from: @parent.id
            redirect_to edit_document_path(@document), flash: { notice: 'Document forked!' }
        else
            render @parent, flash: { error: 'Document could not be forked.' }
        end
    end

    private

    def document_params
        params.require(:document)
            .permit(:name, :language, :content)
    end

    def catch_record_not_found
        yield
    rescue ActiveRecord::RecordNotFound
        redirect_to root_path, flash: { alert: 'Document not found.' }
    end

    def user_has_permission_to_modify?(document)
        return user_signed_in? ? current_user.id === document.user.id : false
    end

    def clone_and_reassign_document(parent)
        document = parent.dup
        document.user = current_user
        document.user_id = current_user.id

        document
    end

end
