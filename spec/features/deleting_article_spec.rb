require 'rails_helper'

RSpec.feature 'Deleting an article' do
    before do
        @article = Article.create(title: 'test title', body: 'test body')
    end

    scenario 'User deletes an article' do
        visit '/'
        click_link @article.title
        click_link 'Delete Article'

        expect(page).to have_content('Article successfully deleted')
        expect(current_path).to eq articles_path
    end
end