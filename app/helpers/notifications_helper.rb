module NotificationsHelper
  def render_notification(notification)
    case notification.type
    when 'solved_mission'
      render partial: 'web/quests/shared/notifications/solved_mission',
             locals: { notification: notification }
    when 'new_mission'
      render partial: 'web/quests/shared/notifications/new_mission',
             locals: { notification: notification }
    end
  end
end
