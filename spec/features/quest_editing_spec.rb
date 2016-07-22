require 'rails_helper'
require_relative '../support/login_form.rb'
require_relative '../support/quest/edit_quest_form.rb'
require_relative '../support/quest/new_quest_form.rb'

feature 'try to edit own quest' do
  given(:user) { FactoryGirl.create(:user) }
  given(:login_form) { LoginForm.new }
  given(:new_quest_form) { NewQuestForm.new }
  given(:edit_quest_form) { EditQuestForm.new }

  background do
    login_form.visit_page.login_as(user)
    new_quest_form.visit_page_by_url.fill_in_with_valid_data().submit
  end

  scenario 'with valid data' do
    edit_quest_form.visit_page_by_click()
                   .fill_in_with_valid_data(name: 'Capybara updated name')
                   .submit
    expect(page).to have_content('Capybara updated name')
    #expect(page).to have_content('Quest was successfully updated.')
  end

  scenario 'with invalid data' do
    edit_quest_form.visit_page_by_click()
                   .fill_in_with_invalid_data()
                   .submit
    expect(page).to have_content("can't be blank")
  end

end

feature 'try to edit not owned quest' do
  given(:user) { FactoryGirl.create(:user) }
  given(:user2) { FactoryGirl.create(:user) }
  given(:login_form) { LoginForm.new }
  given(:new_quest_form) { NewQuestForm.new }

  background do
    login_form.visit_page.login_as(user)
    new_quest_form.visit_page_by_url.fill_in_with_valid_data().submit
    login_form.logout
    login_form.visit_page.login_as(user2)
  end

  scenario 'by clicking from #show' do
    visit('quests/1')
    expect(page).not_to have_css('a', text: 'Edit')
  end

  scenario 'by visiting direct link' do
    visit('quests/1/edit')
    expect(page).to have_content('You can\'t edit this post.')
  end
end
