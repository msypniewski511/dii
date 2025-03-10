class IndustryType < ApplicationRecord
  has_many :business_ideas

  validates :name, presence: true, uniqueness: true
end
