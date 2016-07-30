class Mission < ApplicationRecord

  enum difficulty: [:easy, :medium, :hard, :legendary]

  has_and_belongs_to_many :users
  belongs_to :quest


  validates :task, presence: true



end
