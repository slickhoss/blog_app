require 'rails_helper'

RSpec.feature 'Editing and article' do
    before do
        @article1 = Article.create(title: 'Article1', body: 'Body1')
    end

    scenario 'User updates an article' do
        visit '/'
        click_link @article1.title
        click_link 'Edit Article'

        fill_in 'Title', with: 'new title'
        fill_in 'Body', with: 'new body'
        click_button 'Update Article'

        expect(page).to have_content('Article has been updated')
        expect(page).to have_content('new title')
        expect(page).to have_content('new body')
        expect(page.current_path).to eq(article_path(@article1))
    end

    scenario 'User fails to update an article' do
        visit '/'
        click_link @article1.title
        click_link 'Edit Article'

        fill_in 'Title', with: ''
        fill_in 'Body', with: ''
        click_button 'Update Article'

        expect(page).to have_content('Article has not been updated')
        expect(page.current_path).to eq(article_path(@article1))
    end
end