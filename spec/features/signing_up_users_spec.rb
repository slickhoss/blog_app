require 'rails_helper'

RSpec.feature 'Sign Up Users' do
    
    scenario 'With valid credentials' do
        visit '/'
        click_link 'Sign Up'
        fill_in 'Email', with: 'demo@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Sign up'

        expect(page).to have_content('Welcome! You have signed up successfully.')
    end



    scenario 'With invalid credentials' do
        visit '/'
        click_link 'Sign Up'
        fill_in 'Email', with: 'demo@example.com'
        fill_in 'Password', with: ''
        fill_in 'Password confirmation': ''
        click_button 'Sign up'

        #expect(page).to have_content('Registration Errors')
     end

end