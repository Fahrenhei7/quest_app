class Web::Quests::QuestsController < Web::Quests::ApplicationController
  before_action :set_quest, only: [:show, :edit, :update, :sign, :unsign,
                                   :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update,
                                            :destroy, :sign, :unsign]

  def index
    @owned_quests = Quest.by_user(current_user)
    @not_owned_quests = Quest.exclude_by_user(current_user)
  end

  def show
    @missions = MissionDecorator.decorate_collection(@quest.missions)
  end

  def new
    @quest = current_user.created_quests.new
  end

  def edit
    authorize @quest
  end

  def create
    @quest = current_user.created_quests.new(quest_params)

    if @quest.save
      redirect_to @quest, notice: 'Quest was successfully created.'
    else
      render :new, layout: 'centered_column'
    end
  end

  def update
    authorize @quest

    if @quest.update(quest_params)
      redirect_to @quest, notice: 'Quest was successfully updated.'
    else
      render :edit
    end
  end

  def sign
    authorize @quest

    sign_user = SignToQuest.new(current_user, @quest)
    sign_user.call
    redirect_to @quest, notice: 'Signed to quest'
  end

  def unsign
    authorize @quest

    @quest.signed_users.delete(current_user)
    unsign_user = UnsignFromQuest.new(current_user, @quest)
    unsign_user.call
    redirect_to @quest, notice: 'Unsigned from quest'
  end

  def destroy
    authorize @quest

    @quest.destroy
    redirect_to quests_url, notice: 'Quest was successfully destroyed.'
  end

  private

  def set_quest
    @quest = Quest.find(params[:id])
  end

  def quest_params
    params.require(:quest).permit(:name, :description, :creator_id)
  end
end
