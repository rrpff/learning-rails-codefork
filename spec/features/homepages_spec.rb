require 'rails_helper'

RSpec.feature "Homepage", type: :feature do

    it 'displays a short description' do
        visit '/'
        page.should have_content 'Code pastebin thing.'
    end

end
