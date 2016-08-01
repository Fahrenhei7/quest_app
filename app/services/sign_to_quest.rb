class SignToQuest

  attr_reader :user, :quest

  def initialize(user, quest)
    @user = user
    @quest = quest
  end

  def call
    quest.signed_users << user
  end

end
