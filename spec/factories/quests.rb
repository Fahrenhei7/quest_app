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

FactoryGirl.define do
  factory :quest do
    name 'Simple quest name'
    description 'some description words'
    association :creator , factory: :user
  end
end
