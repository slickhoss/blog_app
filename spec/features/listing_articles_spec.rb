require 'rails_helper'

RSpec.feature 'Listing Articles' do
    
    before do
        @john = User.create(email: 'demo@example.com', password: 'password')
        @article1 = Article.create(title: 'article1', body:'here is a body', user: @john)
        @article2 = Article.create(title: 'article2', body:'Lorem ipsum dolor sit amet', user: @john)
    end

    scenario 'Listing all articles - user not signed in' do
        visit '/'
        expect(page).to have_content('This is the articles page')
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page).to have_content(@article2.title)
        expect(page).to have_content(@article2.body)
        expect(page).to have_link(@article1.title)
        expect(page).to have_link(@article2.title)
        expect(page).not_to have_link('New Article')
    end

    scenario 'Listing all articles - user signed in' do
        login_as(@john)
        visit '/'
        expect(page).to have_content('This is the articles page')
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page).to have_content(@article2.title)
        expect(page).to have_content(@article2.body)
        expect(page).to have_link(@article1.title)
        expect(page).to have_link(@article2.title)
        expect(page).to have_link('New Article')
    end


    scenario 'App lists no articles' do
        Article.delete_all
        visit '/'
        expect(page).to have_content('This is the articles page')
        expect(page).not_to have_content(@article1.title)
        expect(page).not_to have_content(@article1.body)
        expect(page).not_to have_content(@article2.title)
        expect(page).not_to have_content(@article2.body)
        expect(page).not_to have_link(@article1.title)
        expect(page).not_to have_link(@article2.title)

        within("h1#no-articles") do
            expect(page).to have_content('No Articles Created')
        end
    end


end