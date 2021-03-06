# == Schema Information
#
# Table name: missions
#
#  id                :integer          not null, primary key
#  task              :text
#  parting           :text
#  keys              :string           default([]), is an Array
#  quest_id          :integer
#  solved_by_user_id :integer
#  difficulty        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  status            :integer
#

require 'rails_helper'

RSpec.describe Mission, type: :model do
  describe 'custom methods' do
    let(:mission) { FactoryGirl.create(:mission, difficulty: 'hard') }
    it 'cost method' do
      expect(mission.cost).to eq(5)
    end
  end
end
