# == Schema Information
#
# Table name: missions
#
#  id                 :integer          not null, primary key
#  task               :text
#  keys               :string           default([]), is an Array
#  quest_id           :integer
#  difficulty         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  completed_by_users :integer
#

FactoryGirl.define do
  factory :mission do
    task "Mission text factory girl"
    keys ["superkey_one", "superkey_two"]
    association :quest
    difficulty "hard"
  end
end
