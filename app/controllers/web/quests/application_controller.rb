class Web::Quests::ApplicationController < Web::ApplicationController
  helper_method :current_quest, :active_mission

  def current_quest
    @current_quest ||= Quest.find(params[:quest_id])
  end

  def active_mission
    current_quest.missions.where(status: 'active')
  end
end
