class EditQuestForm
  include Capybara::DSL

  def visit_page_by_click
    visit('/quests/1')
    click_on('Edit')

    self
  end

  def visit_page_by_url
    visit('/quests/1/edit')

    self
  end

  def fill_in_with_valid_data(params = {})
    fill_in('Name', with: params.fetch(:name,'Capybara name value' ))
    fill_in('Description', with: params.fetch(:description,'Capybara description value' ))

    self
  end

  def fill_in_with_invalid_data(params = {})
    fill_in('Name', with: params.fetch(:name, ''))
    fill_in('Description', with: params.fetch(:description, 'Capybara description form invalid fill method'))

    self
  end

  def submit
    click_button('Update Quest')
  end


end
