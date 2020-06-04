class Task < ApplicationRecord
  validates :title, :presence => true
  belongs_to :user
  belongs_to :task, foreign_key: "parent_id", class_name: "Task", optional: true
  has_many :tasks, :class_name => 'Task', :foreign_key => 'parent_id'
  scope :activ, -> { where(activ: true) }
end