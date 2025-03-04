class BusinessIdea < ApplicationRecord
  has_one :pestel_analysis, dependent: :destroy
  has_one :swot_analysis, dependent: :destroy
  has_one :porters_five_force, dependent: :destroy

  accepts_nested_attributes_for :pestel_analysis
  accepts_nested_attributes_for :swot_analysis

  belongs_to :user

  VALID_STATUSES = ["Draft", "In Progress", "Submitted", "Approved"]

  validates :title, :description, :country, presence: true
  validates :title, uniqueness: { scope: :user_id }
  validates :status, inclusion: { in: VALID_STATUSES }
end