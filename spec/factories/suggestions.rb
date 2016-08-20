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

FactoryGirl.define do
  factory :suggestion do
    text "MyText"
    rating 1
    user ""
    mission ""
    status 1
  end
end
