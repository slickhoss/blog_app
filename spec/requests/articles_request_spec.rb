require 'rails_helper'

RSpec.describe "Articles", type: :request do
    before do
        @john = User.create(email: 'demo@example.com', password: 'password')
        @john2 = User.create(email: 'demo2@example.com', password: 'password')
        @article1 = Article.create(title: 'Title 1', body: 'Body 1', user: @john)
    end

    describe 'DELETE /articles/:id' do
        context 'with non signed in user' do
            before { delete "/articles/#{@article1.id}"}
            it 'redirects to home page' do
                expect(response.status).to eq 302
                flash_message = 'You need to sign in or sign up before continuing.'
                expect(flash[:alert]).to eq flash_message
            end
        end

        context 'with signed in user, non owner' do
            before do
                login_as(@john2)
                delete "/articles/#{@article1.id}"
            end

            it 'redirects to home page' do 
                expect(response.status).to eq 302
                flash_message = 'You can only delete your own articles.'
                expect(flash[:alert]).to eq flash_message
            end
            
        end

        context 'with signed in user, owner' do
            before do
                login_as(@john)
                delete "/articles/#{@article1.id}"
            end

            it 'successfully deletes article' do
                expect(response.status).to eq 302
                flash_message = 'Article successfully deleted'
                expect(flash[:success]).to eq flash_message
            end
        end
    end
end
