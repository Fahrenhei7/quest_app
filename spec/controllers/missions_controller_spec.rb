require 'rails_helper'

RSpec.describe Web::Quests::MissionsController, type: :controller do

  shared_examples 'public access to missions' do
    let(:quest) { FactoryGirl.create(:quest) }
    let(:mission) { FactoryGirl.create(:mission, quest: quest) }

    describe 'GET #index' do
      before(:each) do
        get :index, params: { quest_id: quest }
      end

      it { expect(response).to render_template(:index) }
      it { expect(assigns(:missions)).to eq(quest.missions) }
    end

    describe 'GET #show' do
      before(:each) do
        get :show, params: { id: mission }
      end

      it { expect(response).to render_template(:show) }
      it { expect(assigns(:mission)).to eq(mission) }
    end
  end

  describe 'guest user' do
    let(:quest) { FactoryGirl.create(:quest) }

    it_behaves_like 'public access to missions'

    describe 'GET #new' do
      it 'redirects to login page' do
        get :new, params: { quest_id: quest }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'POST #create' do
      it 'redirects to login page' do
        post :create, params: { quest_id: quest, mission: FactoryGirl.attributes_for(:mission) }
        expect(response).to redirect_to(new_user_session_url)
      end

      it 'does not change database' do
        expect {
          post :create, params: { quest_id: quest, mission: FactoryGirl.attributes_for(:mission) }
        }.not_to change(Mission, :count)
      end
    end

    describe 'GET #edit' do
      it 'redirects to login page' do
        get :edit, params: { id: FactoryGirl.create(:mission) }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'PATCH #update' do
      let(:mission) { FactoryGirl.create(:mission) }
      let(:new_params) { FactoryGirl.attributes_for(:mission, task: 'New task') }

      it 'redirects to login page' do
        patch :update, params: { id: mission, mission: new_params }
        expect(response).to redirect_to(new_user_session_url)
      end
      it 'does not change record in database' do
        expect {
          patch :update, params: { id: mission, mission: new_params }
        }.not_to change(mission, :task)
      end
    end

    describe 'DELETE #destroy' do
      let!(:mission) { FactoryGirl.create(:mission) }

      it 'redirects to login page' do
        delete :destroy, params: { id: mission }
        expect(response).to redirect_to(new_user_session_url)
      end
      it 'does not delete record from database' do
        expect {
          delete :destroy, params: { id: mission }
        }.not_to change(Mission, :count)
      end
    end

    describe 'POST #check_key' do
      let(:mission) { FactoryGirl.create(:mission) }

      it 'redirects to quests path' do
        post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
        expect(response).to redirect_to(new_user_session_url)
      end
      it 'doesn\'t change database' do
        post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
        mission.reload
        expect(mission.solved_by).to be_nil
      end
    end
  end

  describe 'authenticated user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:quest) { FactoryGirl.create(:quest, creator: user) }
    let(:mission) { FactoryGirl.create(:mission, quest: quest) }
    before do
      sign_in(user)
    end

    it_behaves_like 'public access to missions'

    context 'is the owner of mission\'s quest' do

      describe 'GET #new' do
        it 'assigns a new mission as @mission' do
          get :new, params: { quest_id: quest }
          expect(assigns(:mission)).to be_a_new(Mission)
        end
      end

      describe 'POST #create' do
        context 'valid data' do
          let(:valid_data) { FactoryGirl.attributes_for(:mission) }

          it 'redirects to quest page' do
            post :create, params: { quest_id: quest, mission: valid_data }
            expect(response).to redirect_to(quest_path(quest))
          end
          it 'creates new record in database' do
            expect {
              post :create, params: { quest_id: quest, mission: valid_data }
            }.to change(Mission, :count).by(1)
          end
          it 'does not create notification for non-signed / author users' do
            user2 = FactoryGirl.create(:user)
            quest = FactoryGirl.create(:quest, creator: user, signed_users: [user2])
            expect {
              post :create, params: { quest_id: quest, mission: valid_data }
            }.not_to change(user.notifications, :count)
          end
          it 'creates notification for signed users' do
            user2 = FactoryGirl.create(:user)
            quest = FactoryGirl.create(:quest, creator: user, signed_users: [user2])
            expect {
              post :create, params: { quest_id: quest, mission: valid_data }
            }.to change(user2.notifications, :count).by(1)
          end
        end
        context 'invalid data' do
          let(:invalid_data) { FactoryGirl.attributes_for(:mission, task: '') }

          it 'renders :new template' do
            post :create, params: { quest_id: quest, mission: invalid_data }
            expect(response).to render_template(:new)
          end
          it "doesn't create new record in database" do
            expect {
              post :create, params: { quest_id: quest, mission: invalid_data }
            }.not_to change(Mission, :count)
          end
        end
      end

      describe 'GET #edit' do
        before(:each) { get :edit, params: { id: mission } }

        it 'renders :edit template' do
          expect(response).to render_template(:edit)
        end
        it 'assigns requested quest to template' do
          expect(assigns(:mission)).to eq(mission)
        end
      end

      describe 'PATCH #update' do
        context 'with valid data' do
          let(:valid_data) { FactoryGirl.attributes_for(:mission, task: 'new valid task') }
          before(:each) { patch :update, params: { id: mission, mission: valid_data } }

          it 'redirects to quests#show' do
            expect(response).to redirect_to(mission.quest)
          end
          it 'updates record in database' do
            mission.reload
            expect(mission.task).to eq('new valid task')
          end
        end

        context 'with invalid data' do
          let(:invalid_data) { FactoryGirl.attributes_for(:mission,
                                                          task: '',
                                                          keys: ['newkeyfromspec']) }
          before(:each) { patch :update, params: { id: mission, mission: invalid_data } }

          it 'renders :edit template' do
            expect(response).to render_template(:edit)
          end
          it "doesn't update record in database" do
            mission.reload
            expect(mission.keys).not_to include('newkeyfromspec')
          end
        end
      end

      describe 'DELETE #destroy' do
        let!(:mission) { FactoryGirl.create(:mission, quest: quest) }

        it 'redirects to mission\'s quest show page' do
          delete :destroy, params: { id: mission }
          expect(response).to redirect_to(quest)
        end
        it 'deletes record form database' do
          delete :destroy, params: { id: mission }
          expect(Mission.exists?(mission.id)).to be_falsy
        end
      end

      describe 'POST #check_key' do
        it 'redirects to quests path' do
          post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
          expect(response).to redirect_to(quests_path)
        end
        it 'doesn\'t change database mission users' do
          post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
          mission.reload
          expect(mission.solved_by).to be_nil
        end
        it 'doesn\'t change database user\'s pts' do
          post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
          user.reload
          expect(user.points).to eq(0)
        end
        it 'doesn\'t create new notification about solving' do
          expect{
            post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
          }.not_to change(Notification, :count)
        end
      end
    end

    context 'is not the owner of mission\'s quest' do
      let(:user) { FactoryGirl.create(:user) }
      let(:user2) { FactoryGirl.create(:user) }
      let(:quest) { FactoryGirl.create(:quest, creator: user2) }
      let(:mission) { FactoryGirl.create(:mission, quest: quest) }
      before do
        sign_in(user)
      end

      describe 'GET #new' do
        it 'redirects to quests index page' do
          get :new, params: { quest_id: quest }
          expect(response).to redirect_to(quests_path)
        end
      end

      describe 'POST #create' do
        it 'redirects to quests index page' do
          post :create, params: { quest_id: quest, mission: FactoryGirl.attributes_for(:mission) }
          expect(response).to redirect_to(quests_path)
        end

        it 'does not create new record in database' do
          expect {
            post :create, params: { quest_id: quest, mission: FactoryGirl.attributes_for(:mission) }
          }.not_to change(Mission, :count)
        end
      end

      describe 'GET #edit' do
        it 'redirects to mission\'s quest show' do
          get :edit, params: { id: mission }
          expect(response).to redirect_to(quests_path)
        end
      end

      describe 'PATCH #update' do
        let(:valid_data) { FactoryGirl.attributes_for(:mission, task: 'newtaskfromspec') }

        it 'redirects to mission\'s quest show' do
          patch :update, params: { id: mission, mission: valid_data }
          expect(response).to redirect_to(quests_path)
        end
        it 'does not update record in database' do
          patch :update, params: { id: mission, mission: valid_data }
          mission.reload
          expect(mission.task).not_to eq('newtaskfromspec')
        end
      end

      describe 'DELETE #destroy' do
        let!(:mission) { FactoryGirl.create(:mission, quest: quest) }

        it 'redirects to quests index page' do
          delete :destroy, params: { id: mission }
          expect(response).to redirect_to(quests_path)
        end
        it 'does not delete record from database' do
          delete :destroy, params: { id: mission }
          expect(Mission.exists?(mission.id)).to be_truthy
        end
      end

      describe 'POST #check_key' do

        context 'mission allowed to answer' do
          context 'right key' do
            it 'redirects to quest path' do
              post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
              expect(response).to redirect_to(quest)
            end
            it 'updates missionn\'s users in database' do
              post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
              mission.reload
              expect(mission.solved_by).to eq(user)
            end
            it 'updates user\'s pts in database' do
              post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
              user.reload
              expect(user.points).to eq(mission.cost)
            end
            it 'creates new notifications about solving mission' do
              expect {
                post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
              }.to change(Notification, :count).by(1)
            end
          end
          context 'rigth key wrong case' do
            let(:wrong_case_key) { "sUpeRkEy_ONe" }
            it 'updates missionn\'s users in database' do
              post :check_key, params: { id: mission, mission_key: { key: wrong_case_key } }
              mission.reload
              expect(mission.solved_by).to eq(user)
            end
          end
          context 'wrong key' do
            it 'redirects to quest path' do
              post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
              expect(response).to redirect_to(quest)
            end
            it 'does not update mission\'s users in database' do
              post :check_key, params: { id: mission, mission_key: { key: 'wrong_key' } }
              mission.reload
              expect(mission.solved_by).to be_nil
            end
            it 'does not update user\'s pts' do
              post :check_key, params: { id: mission, mission_key: { key: 'wrong_key' } }
              user.reload
              expect(user.points).to eq(0)
            end
            it 'does notcreates new notifications about solving mission' do
              expect {
                post :check_key, params: { id: mission, mission_key: { key: 'wrong_key' } }
              }.not_to change(Notification, :count)
            end
          end
        end

        context 'mission not yet ready (previous isn\'t solved)' do
          let!(:mission) { FactoryGirl.create(:mission, quest: quest) }
          let!(:mission2) { FactoryGirl.create(:mission, quest: quest) }

          it 'redirects to all quests' do
            post :check_key, params: { id: mission2, mission_key: { key: mission2.keys.first } }
            expect(response).to redirect_to(quests_path)
          end
          it 'does not creates new notification to user' do
            expect {
              post :check_key, params: { id: mission2, mission_key: { key: mission2.keys.first } }
            }.not_to change(Notification, :count)
          end
          it 'does not change user\'s pts' do
            post :check_key, params: { id: mission2, mission_key: { key: mission2.keys.first } }
            user.reload
            expect(user.points).to eq(0)
          end
          it 'does not changes database' do
            post :check_key, params: { id: mission2, mission_key: { key: mission2.keys.first } }
            mission2.reload
            expect(mission2.solved_by).to be_nil
          end
        end
        context 'mission solved by someone else' do
          let(:user3) { FactoryGirl.create(:user) }
          let(:mission) { FactoryGirl.create(:mission, quest: quest, solved_by: user3 ) }

          it 'redirects to quests_path' do
            post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
            expect(response).to redirect_to(quests_path)
          end
          it 'does not creates new notification to user' do
            expect {
              post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
            }.not_to change(Notification, :count)
          end
          it 'does not change database' do
            post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
            mission.reload
            expect(mission.solved_by).to eq(user3)
          end
          it 'does not change user pts' do
            post :check_key, params: { id: mission, mission_key: { key: mission.keys.first } }
            user.reload
            expect(user.points).to eq(0)
          end
        end
      end
    end
  end
end
