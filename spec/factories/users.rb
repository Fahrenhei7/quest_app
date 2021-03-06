# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  created_quests_id      :integer
#  points                 :integer          default(0)
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  missions_id            :integer
#  solved_missions_id     :integer
#

FactoryGirl.define do
  factory :user do
    name 'John'
    sequence(:email) { |n| "samplemail_#{n}@g.com" }
    password  '1234567pswd'
    password_confirmation '1234567pswd'
  end
end

