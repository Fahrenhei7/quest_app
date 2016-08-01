class Mission < ApplicationRecord
  before_validation :delete_blank_keys

  enum difficulty: [:easy, :medium, :hard, :legendary]

  has_and_belongs_to_many :users
  belongs_to :quest


  validates :task, presence: true
  validates :difficulty, presence: true
  validates :keys, presence: true

  private

  def delete_blank_keys
    self.keys.delete_if { |i| i.blank? }
  end

end
