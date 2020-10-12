require 'rails_helper'

RSpec.feature 'Show an article' do
    before do
        @john = User.create(email: 'demo@example.com', password: 'password')
        login_as(@john)
        @article1 = Article.create(title: 'article1', body: 'showing article1', user: @john);
    end

    scenario 'List valid article' do
        visit '/'
        click_link @article1.title
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(current_path).to eq(article_path(@article1))
    end
end