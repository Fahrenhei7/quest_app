class CustomRegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(users)
    #return authenticated_root_url
    return root_url
  end


  def after_edit_path_for(users)
    #flash[:notice] = "Your password successfully updated"
  end

  def update
    super
    flash.delete(:notice)
  end


  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  #def account_update_params
    #params.require(:user).permit(:password, :password_confirmation, :current_password)
  #end
end
