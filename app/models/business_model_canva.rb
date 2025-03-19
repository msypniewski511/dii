class BusinessModelCanva < ApplicationRecord
  belongs_to :business_idea

  validates :business_idea, presence: true

  # validates :key_partners, :key_activities, :key_resources, :value_propositions, :customer_relationships, 
  # :channels, :customer_segments, :cost_structure, :revenue_streams, presence: true

  # # New Extended Fields
  # validates :key_metrics, :customer_pains, :customer_gains, :cost_breakdown, 
  #   :pricing_strategy, :distribution_channels, :partnerships, presence: true, allow_blank: true
  after_save :update_stage_status

  REQUIRED_FIELDS = %w[
    key_partners key_activities key_resources value_propositions 
    customer_relationships distribution_channels customer_segments 
    cost_structure revenue_streams
  ].freeze

  def progress_percentage
    calculate_progress(REQUIRED_FIELDS)
  end

  def completed?
    progress_percentage == 100
  end

  private

  def update_stage_status
    stage = business_idea.stages.find_by(name: "Business Model Definition")
    return unless stage

    stage.update(
      progress_percentage: progress_percentage, 
      status: completed? ? :completed : :in_progress
    )
  end
end
