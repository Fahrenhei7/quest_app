class NewUserSignupForm
  include Capybara::DSL

  def visit_page
    visit('/')
    click_on('Sign up')

    self
  end

  def fill_in_with(params = {})
    fill_in('Name', with: params.fetch(:name, 'John'))
    fill_in('Email', with: params.fetch(:email, 'samplemail@g.com'))
    fill_in('Password', with: params.fetch(:password, '1234567pswd'), match: :prefer_exact)
    fill_in('Password confirmation', with: params.fetch(:password_confirmation, '1234567pswd'), match: :prefer_exact)

    self
  end

  def submit
    click_button('Sign up')

    self
  end

end
