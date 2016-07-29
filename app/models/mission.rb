class Mission < ApplicationRecord

  enum difficulty: [:easy, :medium, :hard, :legendary]

  belongs_to :quest

  validates :task, presence: true



end
