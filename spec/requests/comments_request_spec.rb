require 'rails_helper'

RSpec.describe "Comments", type: :request do
    before do
        @john = User.create(email: 'demo@example.com', password: 'password')
        @fred = User.create(email: 'demo2@example.com', password: 'password')
        @article = Article.create(title: 'Title', body: 'Body', user: @john)
    end

    describe 'POST /articles/:id/comments' do
        context 'with a non signed-in user' do
           before do
                post "/articles/#{@article.id}/comments", params: { comment: {body: 'Test comment'}}
           end
                it 'redirect user to signin page' do
                flash_message = 'Please sign in or sign up first'
                expect(response).to redirect_to(new_user_session_path)
                expect(response.status).to eq 302
                expect(flash[:alert]).to eq flash_message
            end
        end

        context 'with a signed in user' do
            before do 
                login_as(@john)
                post "/articles/#{@article.id}/comments", params: { comment: {body: 'Test comment'}}
            end

            it 'create comment successfully' do
                flash_message = 'Comment has been created'
                expect(response).to redirect_to(article_path(@article.id))
                expect(response.status).to eq 302
                expect(flash[:notice]).to eq flash_message
            end
        end
    end
end
