class BusinessModelCanva < ApplicationRecord
  belongs_to :business_idea

  validates :business_idea, presence: true

  # validates :key_partners, :key_activities, :key_resources, :value_propositions, :customer_relationships, 
  # :channels, :customer_segments, :cost_structure, :revenue_streams, presence: true

  # # New Extended Fields
  # validates :key_metrics, :customer_pains, :customer_gains, :cost_breakdown, 
  #   :pricing_strategy, :distribution_channels, :partnerships, presence: true, allow_blank: true
end
