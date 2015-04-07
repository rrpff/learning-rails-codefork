class SessionsController < ApplicationController

    def create
        auth = request.env['omniauth.auth']
        user = User.find_by(provider: auth['provider'], uid: auth['uid']) || User.create_account(auth)

        session[:user_id] = user.id
        redirect_to root_path, flash: { success: "Welcome, #{user.username}!" }
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, flash: { notice: "Logged out. Ciao!" }
    end

end