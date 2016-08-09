class CheckKey
  attr_reader :user, :mission, :key_params

  def initialize(user, mission, params)
    @user = user
    @mission = mission
    @key_params = params[:key].strip
  end

  def call
    if mission.keys.include? key_params
      mission.users << user
      true
    else
      false
    end
  end
end