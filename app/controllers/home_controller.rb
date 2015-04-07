class HomeController < ApplicationController

    def index
        @documents = latest Document.all
    end

end
