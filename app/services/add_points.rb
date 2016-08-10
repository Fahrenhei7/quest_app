class AddPoints
  attr_reader :user, :number
  def initialize(user, number)
    @user = user
    @number = number
  end

  def call
    user.points += number
    user.save
  end

end
