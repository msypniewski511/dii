class Idea < ApplicationRecord
  belongs_to :user

  enum :status, {
    pending: 0,
    in_progress: 1,
    completed: 2
  }
  enum :priority, {
    high: 0,
    low: 1,
    medium: 2
  }
end
