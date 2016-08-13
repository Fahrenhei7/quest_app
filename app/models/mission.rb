# == Schema Information
#
# Table name: missions
#
#  id         :integer          not null, primary key
#  task       :text
#  keys       :string           default([]), is an Array
#  quest_id   :integer
#  difficulty :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mission < ApplicationRecord
  before_validation :delete_blank_keys

  enum difficulty: [:easy, :medium, :hard, :legendary]

  has_and_belongs_to_many :users
  belongs_to :quest


  validates :task, presence: true
  validates :difficulty, presence: true
  validates :keys, presence: true


  def cost
    case difficulty
    when 'easy'
      1
    when 'medium'
      3
    when 'hard'
      5
    when 'legendary'
      9
    end
  end

  private

  def delete_blank_keys
    self.keys.delete_if { |i| i.blank? }
  end

end
