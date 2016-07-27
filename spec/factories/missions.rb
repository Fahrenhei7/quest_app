FactoryGirl.define do
  factory :mission do
    task "Mission text factory girl"
    key "superkey"
    association :quest
    difficulty 1
  end
end
