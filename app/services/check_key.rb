class CheckKey

  attr_reader :user, :mission, :params

  def initialize(user, mission, params)
    @user = user
    @mission = mission
    @params = params
  end

  def call
    if mission.keys.include? params[:key]
      mission.users << user
      true
    else
      false
    end

  end


end
