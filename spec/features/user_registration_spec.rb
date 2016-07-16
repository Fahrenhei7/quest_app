require 'rails_helper'
require_relative '../support/user/new_user_signup_form'

feature 'Sign up user' do
  let(:new_user_signup_form) { NewUserSignupForm.new }

  scenario 'sign up new user with valid data' do
    new_user_signup_form.visit_page.fill_in_with().submit

    expect(page).to have_content('Welcome!')
    expect(User.last.name).to eq('John')
  end
end
