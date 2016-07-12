class QuestsController < ApplicationController
  before_action :set_quest, only: [:show, :edit, :update, :sign, :unsign, :destroy]

  # GET /quests
  # GET /quests.json
  def index
    @quests = Quest.all
  end

  # GET /quests/1
  # GET /quests/1.json
  def show
  end

  # GET /quests/new
  def new
    @quest = Quest.new
  end

  # GET /quests/1/edit
  def edit
  end

  # POST /quests
  # POST /quests.json
  def create
    @quest = current_user.created_quests.new(quest_params)

    respond_to do |format|
      if @quest.save
        format.html { redirect_to @quest, notice: 'Quest was successfully created.' }
        format.json { render :show, status: :created, location: @quest }
      else
        format.html { render :new }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quests/1
  # PATCH/PUT /quests/1.json
  def update
    respond_to do |format|
      if @quest.update(quest_params)
        format.html { redirect_to @quest, notice: 'Quest was successfully updated.' }
        format.json { render :show, status: :ok, location: @quest }
      else
        format.html { render :edit }
        format.json { render json: @quest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH /quests/:id/sign
  # ADD JSON RESPONSE
  def sign
    @quest.signed_users << current_user
    redirect_to @quest
  rescue ActiveRecord::RecordInvalid => e
    redirect_to @quest, flash[:danger] = e
  end

  # DELETE /quests/:id/unsign
  # ADD JSON RESPONSE
  def unsign
    @quest.signed_users.delete current_user
  end

  # DELETE /quests/1
  # DELETE /quests/1.json
  def destroy
    @quest.destroy
    respond_to do |format|
      format.html { redirect_to quests_url, notice: 'Quest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_quest
    @quest = Quest.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def quest_params
    params.require(:quest).permit(:name, :description, :creator_id)
  end
end
