FactoryGirl.define do
  factory :mission do
    task "Mission text factory girl"
    keys ["superkey_one", "superkey_two"]
    association :quest
    difficulty "hard"
  end
end
