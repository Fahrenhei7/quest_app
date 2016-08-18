class Web::Quests::MissionsController < Web::Quests::ApplicationController
  before_action :set_mission, only: [:show, :edit, :update, :destroy,
                                     :check_key]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @missions = current_quest.missions
  end

  def show; end

  def new
    @mission = current_quest.missions.new
    authorize @mission
    respond_to do |format|
      format.js { render file: 'web/quests/quests/remote/new_mission',
                  layout: false }
      format.html {}
    end
  end

  def edit
    authorize @mission
  end

  def create
    @mission = current_quest.missions.new(mission_params)
    authorize @mission
    respond_to do |format|
      if @mission.save!
        new_notification = CreateNotification.new(
          @mission.quest.signed_users,
          'new_mission',
          'new mission in signed quest',
          {
            quest: @mission.quest.name,
            mission_cost: @mission.cost
          }
        )
        new_notification.call
        format.html { redirect_to quest_path(current_quest),
                      notice: 'Mission was successfully created.' }
        format.js { render file: 'web/quests/quests/remote/create_mission',
                    layout: false }
      else
        format.html { render :new }
        format.js { render file: 'web/quests/quests/remote/new_mission',
                    layout: false }
      end
    end
  end

  def update
    authorize @mission
    if @mission.update(mission_params)
      redirect_to @mission.quest, notice: 'Mission was successfully updated.'
    else
      render :edit, layout: 'centered_column'
    end
  end

  def destroy
    authorize @mission
    @mission.destroy
    redirect_to @mission.quest, notice: 'Mission was successfully destroyed.'
  end

  def check_key
    authorize @mission
    check_key = CheckKey.new(current_user, @mission, submitted_key_params)

    if check_key.call
      flash[:success] = "Right answer! You gained #{@mission.cost} points!"
      redirect_to @mission.quest
    else
      flash[:danger] = 'Wrong key'
      redirect_to @mission.quest
    end
  end

  private

  def set_mission
    @mission = Mission.find(params[:id])
  end

  def submitted_key_params
    params.require(:mission_key).permit(:key)
  end

  def mission_params
    params.require(:mission).permit(:task, :quest_id, :difficulty, keys: [])
  end
end
