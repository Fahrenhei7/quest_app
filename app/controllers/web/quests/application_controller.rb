class Web::Quests::ApplicationController < Web::ApplicationController
  helper_method :current_quest, :choosen_mission

  def current_quest
    @current_quest ||= Quest.find(params[:quest_id])
  end

  def choosen_mission
    @choosen_mission ||= Mission.find(params[:mission_id])
  end
end
