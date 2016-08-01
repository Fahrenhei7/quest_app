module QuestsHelper

  def not_signed_to_quest(user, quest)
    quest.signed_users.exclude? user
  end
end
