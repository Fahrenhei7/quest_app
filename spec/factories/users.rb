FactoryGirl.define do
  factory :user do
    name 'John'
    sequence(:email) { |n| "samplemail_#{n}@g.com" }
    password  '1234567pswd'
    password_confirmation '1234567pswd'
  end
end

