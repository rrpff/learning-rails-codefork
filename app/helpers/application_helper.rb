module ApplicationHelper

    # Set page title
    def page_header(title)
        content_for :title, title
        title
    end

    def display_username(user)
        link_to "@" + user.username, user_path(user)
    end

end