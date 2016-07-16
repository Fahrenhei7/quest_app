require 'rails_helper'

feature 'Log in user' do

  before(:each) do
    visit ('/')
    click_on('Log in')
  end

  scenario 'log in as existing user' do

    user_attributes = FactoryGirl.attributes_for(:user)
    user = User.create(user_attributes)
    # not using FactoryGirl.create, because of user.password method
    fill_in("Email", with: user_attributes[:email])
    fill_in("Password", with: user_attributes[:password])
    click_button('Log in')
    expect(page).to have_content('Signed in successfully.')
    #--- to change
    expect(current_path).to eq(root_path)
    #---
  end

end
