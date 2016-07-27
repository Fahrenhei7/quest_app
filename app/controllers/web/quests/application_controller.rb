class Web::Quests::ApplicationController < Web::ApplicationController

  helper_method :current_quest

  def current_quest
    @current_quest ||= Quest.find(params[:quest_id])
  end

end
