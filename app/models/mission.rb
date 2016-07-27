class Mission < ApplicationRecord
  belongs_to :quest
  validates :task, presence: true

end
