class Document < ActiveRecord::Base
    belongs_to :user
    validates :name, :language, :content,
        presence: true,
        length: {
            minimum: 1
        }

    after_initialize :reference_forked_from

    private

    def reference_forked_from
        if self.forked
            parent_id = self.forked_from
            self.forked_from = Document.find_by(id: parent_id) || nil
        end
    end
end