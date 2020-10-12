require 'rails_helper'

RSpec.feature 'Show an article' do
    before do
        @john = User.create(email: 'demo@example.com', password: 'password')
        login_as(@john)
        @article1 = Article.create(title: 'article1', body: 'showing article1', user: @john);
    end

    scenario 'List valid article - user logged in, owns article' do
        visit '/'
        click_link @article1.title
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page).to have_link('Edit Article')
        expect(page).to have_link('Delete Article')
        expect(current_path).to eq(article_path(@article1))
    end


    scenario "List valid article - user logged in, doesn't own article" do
        @john2 = User.create(email: 'demo2@example.com', password: 'password')
        login_as(@john2)
        visit '/'
        click_link @article1.title
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page).not_to have_link('Edit Article')
        expect(page).not_to have_link('Delete Article')
        expect(current_path).to eq(article_path(@article1))
    end

    scenario 'List valid article - user logged out' do
        visit '/'
        click_link 'Sign Out'    
        click_link @article1.title
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page).not_to have_link('Edit Article')
        expect(page).not_to have_link('Delete Article')
        expect(current_path).to eq(article_path(@article1))      
    end

end