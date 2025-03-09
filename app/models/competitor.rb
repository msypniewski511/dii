class Competitor < ApplicationRecord
  belongs_to :competitor_analysis

  validates :name, presence: true
  validates :description, presence: true
end
