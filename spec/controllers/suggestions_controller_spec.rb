require 'rails_helper'

RSpec.describe Web::Quests::SuggestionsController, type: :controller do

  describe 'guest user' do
    let(:mission) { FactoryGirl.create(:mission) }
    describe 'GET #new' do
      it 'redirects to login page' do
        get :new, params: { mission_id: mission }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
    describe 'POST #create' do
      it 'redirect_to login page' do
        post :create, params: { mission_id: mission, suggestion: FactoryGirl.attributes_for(:suggestion) }
        expect(response).to redirect_to(new_user_session_url)
      end
      it 'doesn\'t create new record in db' do
        expect {
          post :create, params: { mission_id: mission, suggestion: FactoryGirl.attributes_for(:suggestion) }
        }.not_to chagne(Suggestion, :count)
      end
    end
    describe 'GET #edit' do
      it 'redirects to login page' do
        get :edit, params: { id: FactoryGirl.create(:suggestion) }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
    describe 'PATCH #update' do
      let(:suggestion) { FactoryGirl.create(:suggestion) }
      let(:new_params) { FactoryGirl.attributes_for(:suggestion, text: 'new_sug') }
      it 'redirects to login page' do
        patch :update, params: { id: suggestion, suggestion: new_params }
        expect(response).redirect_to(new_user_session_url)
      end
      it 'does not changes database' do
        patch :update, params: { id: suggestion, suggestion: new_params }
        suggestion.reload
        expect(suggestion.text).not_to eq('new_sug')
      end
    end
    describe 'DELETE #destroy' do
      let!(:suggestion) { FactoryGirl.create(:suggestion) }
      it 'redirects to login page' do
        delete :destroy, params: { id: suggestion }
        expect(response).to redirect_to(new_user_session_url)
      end
      it 'doew not delete suggestion from database' do
        expect {
          delete :destroy, params: { id: suggestion }
        }.not_to chagne(Suggestion, :count)
      end
    end
  end
  describe 'authenticated user' do
    let(:user) { FactoryGirl.create(:user) }
    let(:mission) { FactoryGirl.create(:mission) }
    before do
      sign_in user
    end

    describe 'GET #new' do
      it 'assigns new suggestion to template' do
        get :new, params: { mission_id: mission }
        expect(assigns(:suggestion)).to be_a_new(Suggestion)
      end
    end

    describe 'POST #create' do
      context 'valid data' do
        let(:valid_data) { FactoryGirl.attributes_for(:suggestion) }
        it 'redirects to mission\'s quest path after create' do
          post :create, params: { mission_id: mission, suggestion: valid_data }
          expect(response).to redirect_to(quest_path(mission.quest))
        end
        it 'creates new record in database' do
          expect{
            post :create, params: { mission_id: mission, suggestion: valid_data }
          }.to change(Suggestion, :count).by(1)
        end
      end
      context 'invalid data' do
        let(:invalid_data) { FactoryGirl.attributes_for(:suggestion, text: '') }
        it 'renders :new template' do
          post :create, params: { mission_id: mission, suggestion: invalid_data }
          expect(response).to render_template(:new)
        end
        it 'does not change database' do
          expect {
            post :create, params: { mission_id: mission, suggestion: invalid_data }
          }.not_to change(Suggestion, :count)
        end
      end
    end
    context 'is the owner of suggestion' do
      let(:suggestion) { FactoryGirl.create(:suggestion, user: user) }
      describe 'GET #edit' do
        before { get :edit, params: id: suggestion }
        it 'renders :edit template' do
          expect(response).to render_template(:edit)
        end
        it 'assigns requested suggestion to template' do
          expect(assigns(:suggestion)).to eq(suggestion)
        end
      end
      describe 'PATCH #update' do
        context 'with valid data' do
          let(:valid_data) { FactoryGirl.attrbutes_for(:suggestion, text: 'new_val_sug') }
          it 'redirects to mission\'s quest' do
            patch :update, params: { id: suggestion, suggestion: valid_data }
            expect(response).to redirect_to(mission.quest)
          end
          it 'updates database record' do
            patch :update, params: { id: suggestion, suggestion: valid_data }
            suggestion.reload
            expect(suggestion.text).to eq('new_val_sug')
          end
        end
        context 'with invalid data' do
          let(:invalid_data) { FactoryGirl.attrbutes_for(:suggestion, text: '') }
          it 'render :edit template' do
            patch :update, params: { id: suggestion, suggestion: invalid_data }
            expect(response).to render_template(:edit)
          end
          it 'updates database record' do
            patch :update, params: { id: suggestion, suggestion: invalid_data }
            suggestion.reload
            expect(suggestion.text).not_to eq('new_val_sug')
          end
        end
      end
      describe 'DELETE #destroy' do
        let!(:suggestion) { FactoryGirl.create(:suggestion, user: user) }
        before { delete :destroy, params: { id: suggestion } }
        it 'redirects to mission\'s quest page' do
          expect(response).to redirect_to(mission.quest)
        end
        it 'deteles record from database' do
          expect(Suggestion.exists?(suggestion.id)).to be_falsy
        end
      end
    end
    context 'is not the owner of suggestion ' do
      let(:user2) { FactoryGirl.create(:user) }
      let(:suggestion) { FactoryGirl.create(:suggestion, user: user2) }
      describe 'GET #edit' do
        it 'redirects to quests#index(pundit)' do
          get :edit, params: { id: suggestion }
          expect(response).to redirect_to(quests_path)
        end
      end
      describe 'PATCH #update' do
        let(:valid_data) { FactoryGirl.attributes_for(:suggestion, text: 'new_val_sug') }
        it 'redirect_to quests#index(pundit)' do
          patch :update, params: { id: suggestion, suggestion: valid_data }
          expect(response).to redirect_to(quests_path)
        end
        it 'does not update record in database' do
          patch :update, params: { id: suggestion, suggestion: valid_data }
          suggestion.reload
          expect(suggestion.text).not_to eq('new_val_sug')
        end
      end
      describe 'DELETE #destroy' do
        let!(:suggestion) { FactoryGirl.create(:suggestion, user: user2) }
        before { delete :destroy, params: { id: suggestion } }
        it 'redirects to quests#index(pundit)' do
          expect(response).to redirect_to(quests_path)
        end
        it 'does not delte record from db' do
          expect(Suggestion.exists?(suggestion.id)).to be_truthy
        end
      end
    end
  end
end
