
class Competitor < ApplicationRecord
  belongs_to :competitor_analysis

  validates :name, presence: true
  validates :description, presence: true

  after_update :update_analysis_stage_status, if: :saved_change_to_five_forces?

  private

  def update_analysis_stage_status
    competitor_analysis.update_stage_status
  end
end