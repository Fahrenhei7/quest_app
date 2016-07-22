require 'rails_helper'
require_relative '../support/login_form'
require_relative '../support/quest/new_quest_form'

feature 'create new quest as logged in user' do

  given(:user) { FactoryGirl.create(:user) }
  given(:login_form) { LoginForm.new }
  given(:new_quest_form) { NewQuestForm.new }
  background do
    login_form.visit_page.login_as(user)
  end

  scenario 'with valid data' do
    new_quest_form.visit_page_by_click.fill_in_with_valid_data().submit
    expect(page).to have_content('Capybara new name')
  end
  scenario 'with invalid data' do
    new_quest_form.visit_page_by_click.fill_in_with_invalid_data().submit
    expect(page).to have_content("can't be blank")
  end

end

feature 'create new quest as non logged in user' do
  given(:new_quest_form) { NewQuestForm.new }

  scenario 'by clicking link' do
    visit('/')
    expect(page).not_to have_content('Create new quest')
  end
  scenario 'by visiting url' do
    new_quest_form.visit_page_by_url
    expect(page).to have_content('You need to sign in')
  end

end











