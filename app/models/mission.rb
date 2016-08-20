# == Schema Information
#
# Table name: missions
#
#  id                :integer          not null, primary key
#  task              :text
#  parting           :text
#  keys              :string           default([]), is an Array
#  quest_id          :integer
#  solved_by_user_id :integer
#  difficulty        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  status            :integer
#

class Mission < ApplicationRecord
  before_validation :delete_blank_keys
  after_save :set_status_all_missions

  enum difficulty: [:easy, :medium, :hard, :legendary]
  enum status: [:solved, :active, :locked]

  belongs_to :quest
  belongs_to :solved_by, class_name: 'User', foreign_key: :solved_by_user_id, \
    optional: true


  validates :task, presence: true
  validates :difficulty, presence: true
  validates :keys, presence: true

  def prev
    quest.missions.where('id < ?', id).last
  end

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

  def set_status_all_missions
    quest.missions.each do |m|
      new_status = if m.solved_by.present?
                     'solved'
                   elsif m.prev.nil? || m.prev.solved?
                     'active'
                   elsif m.prev.solved_by.nil?
                     'locked'
                   end
      m.update_column(:status, new_status)
    end
  end

  def delete_blank_keys
    self.keys.delete_if { |i| i.blank? }
  end

end
