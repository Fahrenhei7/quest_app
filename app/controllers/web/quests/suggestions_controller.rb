class Web::Quests::SuggestionsController < Web::Quests::ApplicationController
  before_action :set_suggestion, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @suggestion = Mission.find(params[:mission_id]).suggestions.new
  end

  def edit
    authorize @suggestion
  end

  def create
    @suggestion = choosen_mission.suggestions.new(suggestion_params)
    if @suggestion.save
      redirect_to current_quest, notice: 'Suggestion submitted'
    else
      render :new, layout: 'centered_column'
    end
  end

  def update
    authorize @suggestion

    if @suggestion.update(suggestion_params)
      redirect_to current_quest, notice: 'Suggestion successfully updated'
    else
      render :edit, layout: 'centered_column'
    end
  end

  def destroy
    authorize @suggestion

    @suggestion.destroy
    redirect_to current_quest, notice: 'Quest was successfully destroyed.'
  end

  private

  def set_suggestion
    @suggestion = Suggestion.find(params[:id])
  end

  def suggestion_params
    params.require(:suggestion)
          .permit(:text, :mission_id, :user_id)
          .merge(user: current_user)
  end

  def current_quest
    @suggestion.mission.quest
  end
end
