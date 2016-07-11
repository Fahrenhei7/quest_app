module QuestsHelper
  # views helpers

  def current_user_can_sign?(quest)
    quest.creator != current_user && quest.signed_users.exclude?(current_user)
  end

  def current_user_can_unsign?(quest)
    quest.signed_users.include?(current_user)
  end

  def current_user_owner_of_quest(quest)
    quest.creator == current_user
  end

end
