class CompetitorAnalysis < ApplicationRecord
  belongs_to :business_idea
  has_many :competitors, dependent: :destroy

  validates :business_idea, presence: true

  def country
    business_idea.country
  end
end
