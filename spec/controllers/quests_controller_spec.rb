require 'rails_helper'

RSpec.describe Web::Quests::QuestsController, type: :controller do
  shared_examples 'public access to quests' do
    describe 'GET #index' do
      before(:each) { get :index }

      #it { skip; expect(response).to render_template(:index) }
      #it { skip; expect(assigns(:quests)).to eq(Quest.all) }
    end

    describe 'GET #show' do
      let(:quest) { FactoryGirl.create(:quest) }
      before(:each) { get :show, params: { id: quest } }

      it { expect(response).to render_template(:show) }
      it { expect(assigns(:quest)).to eq(quest) }
      it { expect(assigns(:missions)).to eq(quest.missions) }
    end
  end

  describe 'guest user' do
    it_behaves_like 'public access to quests'

    describe 'GET #new' do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'POST #create' do
      it 'redirects to login page' do
        post :create, params: { quest: FactoryGirl.attributes_for(:quest) }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'GET #edit' do
      it 'redirects to login page' do
        get :edit, params: { id: FactoryGirl.create(:quest) }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'PATCH #update' do
      it 'redirects to login page' do
        patch :update, params: { id: FactoryGirl.create(:quest),
                                 quest: FactoryGirl.attributes_for(:quest, name: 'New name') }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to login page' do
        delete :destroy, params: { id: FactoryGirl.create(:quest) }
        expect(response).to redirect_to(new_user_session_url)
      end
    end

    describe 'POST #sign' do
      let(:quest) { FactoryGirl.create(:quest) }

      it 'redirects to quests index path' do
        post :sign, params: { id: quest }
        expect(response).to redirect_to(new_user_session_url)
      end
      it 'does not update database' do
        expect {
          post :sign, params: { id: quest }
        }.not_to change(quest.signed_users, :count)
      end
    end
  end

  describe 'authenticated user' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
    end

    it_behaves_like 'public access to quests'

    describe 'GET #index' do
      before(:each) { get :index }
      it { expect(response).to render_template(:index) }
      it { expect(assigns(:not_owned_quests)).to eq(Quest.exclude_by_user(user)) }
      it { expect(assigns(:notifications)).to eq(user.notifications) }
    end

    describe 'GET #new' do
      before(:each) { get :new }

      it 'renders :new template' do
        expect(response).to render_template(:new)
      end
      it 'assigns new Quest to template' do
        expect(assigns(:quest)).to be_a_new(Quest)
      end
    end

    describe 'POST #create' do
      context 'valid data' do
        let(:valid_data) { FactoryGirl.attributes_for(:quest) }

        it 'redirects to quest#show' do
          post :create, params: { quest: valid_data }
          expect(response).to redirect_to(quest_path(assigns[:quest]))
        end
        it 'creates new record in database' do
          expect {
            post :create, params: { quest: valid_data }
          }.to change(Quest, :count).by(1)
        end
      end

      context 'invalid data' do
        let(:invalid_data) { FactoryGirl.attributes_for(:quest, name: '') }

        it 'renders :new template' do
          post :create, params: { quest: invalid_data }
          expect(response).to render_template(:new)
        end
        it "doesn't create new record in database" do
          expect {
            post :create, params: { quest: invalid_data }
          }.not_to change(Quest, :count)
        end
      end
    end

    context 'is the owner of quest' do
      let(:quest) { FactoryGirl.create(:quest, creator: user) }

      describe 'GET #edit' do
        before(:each) { get :edit, params: { id: quest } }

        it 'renders :edit template' do
          expect(response).to render_template(:edit)
        end
        it 'assigns requested quest to template' do
          expect(assigns(:quest)).to eq(quest)
        end
      end

      describe 'PATCH #update' do
        context 'with valid data' do
          let(:valid_data) { FactoryGirl.attributes_for(:quest, name: 'new valid name') }
          before(:each) { patch :update, params: { id: quest, quest: valid_data } }

          it 'redirects to quests#show' do
            expect(response).to redirect_to(quest)
          end
          it 'updates record in database' do
            quest.reload
            expect(quest.name).to eq('new valid name')
          end
        end

        context 'with invalid data' do
          let(:invalid_data) { FactoryGirl.attributes_for(:quest,
                                                          name: '',
                                                          description: 'new description') }
          before(:each) { patch :update, params: { id: quest, quest: invalid_data } }

          it 'renders :edit template' do
            expect(response).to render_template(:edit)
          end
          it "doesn't update record in database" do
            quest.reload
            expect(quest.description).not_to eq('new description')
          end
        end
      end

      describe 'DELETE #destroy' do
        let!(:quest) { FactoryGirl.create(:quest, creator: user) }
        before(:each) { delete :destroy, params: { id: quest } }

        it 'redirects to quests#index' do
          expect(response).to redirect_to(quests_path)
        end
        it 'deletes record from database' do
          expect(Quest.exists?(quest.id)).to be_falsy
        end
      end

      describe 'POST #sign' do
        it 'redirects to quests index path' do
          post :sign, params: { id: quest }
          expect(response).to redirect_to(quests_path)
        end
        it 'does not update database' do
          expect {
            post :sign, params: { id: quest }
          }.not_to change(quest.signed_users, :count)
        end
      end
    end

    context 'is not the owner of quest' do
      let(:quest) { FactoryGirl.create(:quest) }

      describe 'GET #edit' do
        it 'redirects to quests page' do
          get :edit, params: { id: quest }
          expect(response).to redirect_to(quests_path)
        end
      end

      describe 'PATCH #update' do
        it 'redirects to quests page' do
          patch :update, params: { id: quest,
                                   quest: FactoryGirl.attributes_for(:quest, name: 'New name') }
          expect(response).to redirect_to(quests_path)
        end
        it "doesn't update record in database" do
          patch :update, params: { id: quest,
                                   quest: FactoryGirl.attributes_for(:quest, name: 'New name') }
          quest.reload
          expect(quest.name).not_to eq('New name')
        end
      end

      describe 'DELETE #destroy' do
        it 'doesn\'t change database' do
          delete :destroy, params: { id: quest }
          expect(Quest.exists?(quest.id)).to be_truthy
        end
      end

      describe 'POST #sign' do
        it 'redirects to quest page' do
          post :sign, params: { id: quest }
          expect(response).to redirect_to(quest)
        end
        it 'changes database' do
          expect {
            post :sign, params: { id: quest }
          }.to change(quest.signed_users, :count).by(1)
        end

        context 'as already signed user' do
          let(:quest) { FactoryGirl.create(:quest, signed_users: [user]) }

          it 'redirects to quests index page' do
            post :sign, params: { id: quest }
            expect(response).to redirect_to(quests_path)
          end
        end
      end

      describe 'DELETE #unsign' do
        context 'as already signed user' do
          let(:quest) { FactoryGirl.create(:quest, signed_users: [user]) }
          it 'redirects to quest page' do
            delete :unsign, params: { id: quest }
            expect(response).to redirect_to(quest)
          end
          it 'changes database' do
            expect {
              delete :unsign, params: { id: quest }
            }.to change(quest.signed_users, :count).by(-1)
          end
        end
        context 'as non-signed user' do
          it 'redirects to quests path' do
            delete :unsign, params: { id: quest }
            expect(response).to redirect_to(quests_path)
          end
        end
      end
    end
  end
end
