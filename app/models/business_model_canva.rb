class BusinessModelCanva < ApplicationRecord
  belongs_to :business_idea

  validates :business_idea, presence: true
end
