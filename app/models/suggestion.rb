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

class Suggestion < ApplicationRecord
end
