require 'rails_helper'
require_relative '../support/login_form'
require_relative '../support/quest/new_quest_form'

feature 'create new quest as logged in user' do

  let(:user) { FactoryGirl.create(:user) }
  let(:login_form) { LoginForm.new }
  let(:new_quest_form) { NewQuestForm.new }
  before do
    login_form.visit_page.login_as(user)
  end
  # todo: check out wtf is happening with #background and #given


  scenario 'create quest with valid data' do
    new_quest_form.visit_page_by_click.fill_in_with_valid_data().submit
    expect(page).to have_content('capybara new name')
  end

  scenario 'create quest with invalid data' do
    new_quest_form.visit_page_by_click.fill_in_with_invalid_data().submit
    expect(page).to have_content("can't be blank")
  end

end

feature 'create new quest as non logged in user' do
  let(:new_quest_form) { NewQuestForm.new }

  scenario 'try to create quest by clicking link' do
    visit('/')
    expect(page).not_to have_content('Create new quest')
  end

  scenario 'try to create quest by visiting url' do
    new_quest_form.visit_page_by_url
    expect(page).to have_content('You need to sign in')
  end

end











