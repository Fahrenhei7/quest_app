require 'rails_helper'

RSpec.describe QuestsController, type: :controller do

  describe 'GET #index' do
    before(:each) { get :index }

    it { expect(response).to render_template(:index) }
    it { expect(assigns(:quests)).to eq(Quest.all) }
  end

  describe 'GET #show' do
    let(:quest) { FactoryGirl.create(:quest) }
    before(:each) { get :show, params: { id: quest } }

    it { expect(response).to render_template(:show) }
    it { expect(assigns(:quest)).to eq(quest) }
  end

  describe 'POST #create' do
    context 'as logined user' do
      login_user
      context 'valid data' do
        let(:valid_data) { FactoryGirl.attributes_for(:quest) }
        it 'redirects to quest#show' do
          post :create, params: { quest: valid_data }
          expect(response).to redirect_to(quest_path(assigns[:quest]))
        end
        it 'creates new quest in database' do
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
        it "doesn't create new quest in database" do
          expect {
            post :create, params: { quest: invalid_data }
          }.not_to change(Quest, :count)
        end
      end
    end
    context 'as non-logined user' do
      let(:valid_data) { FactoryGirl.attributes_for(:quest) }
      it 'returns 401 unauthorized ' do
        post :create, params: { quest: valid_data }
        expect(response).not_to have_http_status(200)
      end
    end

  end
end
