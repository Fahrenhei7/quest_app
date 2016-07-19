class NewQuestForm
  include Capybara::DSL

  def visit_page_by_click
    visit('/')
    click_on('Create new quest')

    self
  end

  def visit_page_by_url
    visit('/quests/new')

    self
  end

  def fill_in_with_valid_data(params = {})
    fill_in('Name', with: params.fetch(:name, 'Capybara new name'))
    fill_in('Description', with: params.fetch(:description, 'Capybara new description'))

    self
  end

  def fill_in_with_invalid_data(params = {})
    fill_in('Name', with: params.fetch(:name, ''))
    fill_in('Description', with: params.fetch(:description, 'Capybara new description'))

    self
  end

  def submit
    click_button('Create Quest')

    self
  end

end
