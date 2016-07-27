class Web::Quests::MissionsController < Web::Quests::ApplicationController
  before_action :set_mission, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @missions = current_quest.missions
  end

  def show
  end

  def new
    @mission = current_quest.missions.new
    authorize @mission
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
        format.json { render :show, status: :created, location: @mission }
      else
        format.html { render :new }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @mission

    respond_to do |format|
      if @mission.update(mission_params)
        format.html { redirect_to @mission, notice: 'Mission was successfully updated.' }
        format.json { render :show, status: :ok, location: @mission }
      else
        format.html { render :edit }
        format.json { render json: @mission.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @mission

    @mission.destroy
    respond_to do |format|
      format.html { redirect_to @mission.quest, notice: 'Mission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_mission
    @mission = Mission.find(params[:id])
  end

  def mission_params
    params.require(:mission).permit(:task, :key, :quest_id, :difficulty)
  end

end
