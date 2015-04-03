require 'rails_helper'

RSpec.describe HomeController, type: :controller do

    describe 'GET #index' do

        it 'should respond with status 200' do
            get :index
            response.should have_http_status 200
        end

    end

end
