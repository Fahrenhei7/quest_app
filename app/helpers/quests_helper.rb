module QuestsHelper
  def signed_to_quest(user, quest)
    quest.signed_users.include? user
  end
end
