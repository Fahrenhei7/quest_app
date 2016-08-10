class MissionDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def is_solved_by_user?(user)
    object.users.include?(user)
  end

  def is_owned_by_user?(user)
    object.quest.creator == user
  end

end
