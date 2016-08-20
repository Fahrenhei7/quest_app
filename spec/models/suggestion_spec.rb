# == Schema Information
#
# Table name: suggestions
#
#  id         :integer          not null, primary key
#  text       :text
#  rating     :integer
#  mission_id :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Suggestion, type: :model do
  it { should validate_presence_of(:text) }
  it { should belong_to(:mission) }
end
