require 'rails_helper'

RSpec.feature 'Show an article' do
    before do
        @article1 = Article.create(title: 'article1', body: 'showing article1');
    end

    scenario 'List valid article' do
        visit '/'
        click_link @article1.title
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(current_path).to eq(article_path(@article1))
    end
end