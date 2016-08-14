module ApplicationHelper
  def user_email_unconfirmed?
    current_user.confirmed_at == nil
  end
end
