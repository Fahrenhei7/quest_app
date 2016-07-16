require 'rails_helper'
require_relative '../support/user/new_user_signup_form'


feature 'Sign up user' do

  let(:new_user_signup_form) { NewUserSignupForm.new }

  scenario 'with valid data' do
    new_user_signup_form.visit_page.fill_in_with().submit

    expect(page).to have_content('Welcome! You have signed up successfully.')
    #--- to change
    expect(current_path).to eq(root_path)
    #---
    expect(User.last.name).to eq('John')
  end

  scenario 'with invalid name' do
    new_user_signup_form.visit_page.fill_in_with(name: '').submit
    expect(page).to have_content('can\'t be blank')
    expect(User.last).to be_nil
  end

  scenario 'with different pswd/confirm_pswd' do
    new_user_signup_form.visit_page
                        .fill_in_with(password_confirmation: 'anotherpass')
                        .submit
    expect(page).to have_content('doesn\'t match')
    expect(User.last).to be_nil
  end
end
