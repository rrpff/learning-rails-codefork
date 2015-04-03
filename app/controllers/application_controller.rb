class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    helper_method :user_signed_in?, :current_user, :latest

    private

    def current_user
        user_signed_in? ? User.find(session[:user_id]) : nil
    end

    def user_signed_in?
        session[:user_id]
    end

    def latest(query, limit=25)
        query.order(created_at: :desc)
            .limit(limit)
    end
end
