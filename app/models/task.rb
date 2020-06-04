class Task < ApplicationRecord
  belongs_to :user
  scope :activ, -> { where(activ: true) }
end