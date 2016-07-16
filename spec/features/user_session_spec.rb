require 'rails_helper'

feature 'Log in user' do

  before(:each) do
    visit ('/')
    click_on('Log in')
  end

  scenario 'log in as existing user' do

    user = FactoryGirl.create(:user)
    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)
    click_button('Log in')
    expect(page).to have_content('Signed in successfully.')
    #--- to change
    expect(current_path).to eq(root_path)
    #---
  end

  scenario 'log in as non-existing user'

end
