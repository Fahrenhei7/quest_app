FactoryGirl.define do
  factory :quest do
    name 'Simple quest name'
    description 'some description words'
    association :creator , factory: :user
  end
end
