module ApplicationHelper

    # Set page title
    def page_header(title)
        content_for :title, title
        title
    end

end