class BusinessIdea < ApplicationRecord
  has_one :pestel_analysis, dependent: :destroy
  has_one :swot_analysis, dependent: :destroy

  accepts_nested_attributes_for :pestel_analysis
  accepts_nested_attributes_for :swot_analysis

  belongs_to :user

  validates :title, :description, :country, presence: true
  validates :title, uniqueness: true
end