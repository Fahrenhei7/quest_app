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

  end
end
