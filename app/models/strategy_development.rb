class StrategyDevelopment < ApplicationRecord
  belongs_to :business_idea

  after_save :update_stage_status
  REQUIRED_FIELDS = %w[
    vision mission strategic_goals core_strategy
    value_chain marketing_strategy competitive_strategy
    swot_actions kpis
  ]

  def progress_percentage
    calculate_progress(REQUIRED_FIELDS)
  end

  def completed?
    progress_percentage == 100
  end

  private
  def update_stage_status
    stage = business_idea.stages.find_by(name: "Strategy Development")
    return unless stage

    stage.update(
      progress_percentage: calculate_progress(REQUIRED_FIELDS),
      status: completed? ? :completed : :in_progress
    )
  end
end
