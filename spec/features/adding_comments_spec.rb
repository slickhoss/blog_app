require 'rails_helper'

RSpec.feature 'Adding comments to articles' do
    before do
        @john = User.create(email: 'demo@example.com', password: 'password')
        @fred = User.create(email: 'demo2@example.com', password: 'password')
        @article1 = Article.create(title: 'Title one', body: 'body', user: @john)
    end

    scenario 'signed in user submits comment' do
        login_as(@fred)
        visit '/'
        click_link @article1.title
        fill_in 'New Comment', with: 'Test comment'
        click_button "Add Comment"

        expect(page).to have_content("Comment has been created")
        expect(page).to have_content('Test comment')
        expect(current_path).to eq(article_path(@article1.id))
    end
end