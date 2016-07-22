require 'rails_helper'

feature 'Log in' do
  given(:user) { FactoryGirl.create(:user) }
  background do
    visit ('/')
    click_on('Log in')
  end

  scenario 'as existing user' do
    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)
    click_button('Log in')
    expect(page).to have_content('Signed in successfully.')
    #--- to change
    expect(current_path).to eq(root_path)
    #---
  end
  scenario 'as non-existing user' do
    fill_in("Email", with: "non-existing-email@g.co")
    fill_in("Password", with: user.password)
    click_button('Log in')
    expect(page).not_to have_content('Signed in successfully.')
  end

end
