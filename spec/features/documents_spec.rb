require 'rails_helper'

RSpec.feature "Documents", type: :feature do

    background do
        # Fake OAuth login
        visit '/auth/github/callback'

        # Create a second user
        User.create uid: 123,
            provider: :test,
            username: 'not_you'

        # Create a test document which test owns
        Document.create! name: 'test',
            language: 'text',
            content: 'test',
            user_id: 1

        # Create a test document which not_you owns
        Document.create! name: 'test2',
            language: 'text',
            content: 'test',
            user_id: 2
    end

    feature 'Creating a new document' do

        scenario 'Providing valid data' do
            visit '/new'

            within '.new_document' do
                fill_in 'Name', with: 'test_post'
                fill_in 'Language', with: 'javascript'
                fill_in 'document[content]', with: 'function(){ console.log("test"); }'
            end

            click_button 'Create Document'
            page.should have_content 'test_post'
        end

        scenario 'Providing invalid data' do
            visit '/new'

            click_button 'Create Document'
            page.should have_content 'Found 6 errors.'
        end

    end

    feature 'Reading a document' do

        scenario 'Document exists' do
            visit '/1'
            page.should have_content 'this_is_you'
            page.should have_content 'text'
            page.should have_content 'test'
        end

        scenario 'Document does not exist' do
            visit '/200'

            current_path.should === '/'
            page.should have_content 'Document not found.'
        end

    end

    feature 'Editing a document' do

        scenario 'Editing a document which you own' do
            visit '/1'

            click_link 'Update'

            within '.edit_document' do
                fill_in 'Name', with: 'altered_test_post'
            end

            click_button 'Update Document'

            current_path.should === '/1'
            page.should have_content 'altered_test_post'
        end

        scenario 'Editing a document which you don\'t own' do
            visit '/2'

            page.should_not have_content 'Update'
        end

    end

    feature 'Deleting a document' do

        scenario 'Deleting a document which you own' do
            visit '/1'

            click_link 'Delete'
            current_path.should === '/'
        end

        scenario 'Deleting a document which you don\'t own' do
            visit '/2'

            page.should_not have_content 'Delete'
        end

    end

    feature 'Forking a document' do

        scenario 'Forking any document' do
            visit '/2'

            click_link 'Fork'
            current_path.should === '/3/edit'

            click_button 'Update Document'

            current_path.should === '/3'
            page.should have_content 'this_is_you'
        end

    end

end
