require 'rails_helper'

RSpec.feature 'Listing Articles' do
    
    before do
        @article1 = Article.create(title: 'article1', body:'here is a body')
        @article2 = Article.create(title: 'article2', body:'Lorem ipsum dolor sit amet')
    end

    scenario 'User lists all articles' do
        visit '/'
        expect(page).to have_content('This is the articles page')
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page).to have_content(@article2.title)
        expect(page).to have_content(@article2.body)
        expect(page).to have_link(@article1.title)
        expect(page).to have_link(@article2.title)
   
    end


end