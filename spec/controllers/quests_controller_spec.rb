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
end
