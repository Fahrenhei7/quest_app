class Web::Quests::MissionsController < Web::Quests::ApplicationController
  before_action :set_mission, only: [:show, :edit, :update, :destroy, :check_key]
  before_action :authenticate_user!, except: [:index, :show, :check_key]

  def index
    @missions = current_quest.missions
  end

  def show; end

  def new
    @mission = current_quest.missions.new
    authorize @mission

    respond_to do |format|
      format.js { render file: 'web/quests/quests/remote/new_mission', layout: false}
      format.html { }
    end
  end

  def edit
    authorize @mission
  end

  def create
    @mission = current_quest.missions.new(mission_params)
    authorize @mission

    respond_to do |format|
      if @mission.save
        format.html { redirect_to quest_path(current_quest), notice: 'Mission was successfully created.' }
        format.js { render file: 'web/quests/quests/remote/create_mission', layout: false }
      else
        format.html { render :new }
        format.js { render file: 'web/quests/quests/remote/new_mission', layout: false  }
      end
    end
  end

  def update
    authorize @mission

    if @mission.update(mission_params)
      redirect_to @mission, notice: 'Mission was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @mission

    @mission.destroy
    redirect_to @mission.quest, notice: 'Mission was successfully destroyed.'
  end

  def check_key
    authorize @mission

    checking = CheckKey.new(current_user, @mission, submitted_key_params)
    if checking.call
      flash[:notice] = 'SOLVED!'
      redirect_to authenticated_root_path
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
