# == Schema Information
#
# Table name: quests
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  creator_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

describe Quest do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(4) }
    it { should validate_length_of(:name).is_at_most(45) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_least(15) }
    it { should validate_length_of(:description).is_at_most(600) }
    it { should belong_to(:creator) }
  end
end
