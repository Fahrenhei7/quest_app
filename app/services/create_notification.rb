class CreateNotification
  attr_reader :body, :type, :info, :users

  def initialize(users, type, body, info=nil)
    @users = users
    @type = type
    @body = body
    @info = info
  end

  def call
    notification = Notification.new(body: body, type: type, info: info, users: [users])
    if notification.save
      true
    else
      false
    end
  end
end
