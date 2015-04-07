class UsersController < ApplicationController

    def index
        @users = User.all.order('username ASC')
    end

    def show
        username = params[:id]
        @user = User.find_by username: username

        if not @user
            redirect_to root_path,
                alert: "There is no user called #{username}."
        end
    end

end