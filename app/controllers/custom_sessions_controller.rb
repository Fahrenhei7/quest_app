class CustomSessionsController < Devise::SessionsController


  def after_sign_in_path_for(users)
    return authenticated_root_url
  end

end
