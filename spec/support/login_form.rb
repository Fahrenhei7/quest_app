class LoginForm
  include Capybara::DSL

  def visit_page
    visit('/login')
    self
  end

  def login_as(user)
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_button('Log in')
    self
  end

  def logout
    click_on('Log out')
  end


end
