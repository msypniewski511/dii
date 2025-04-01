# app/models/financial_plan.rb
class FinancialPlan < ApplicationRecord
  belongs_to :business_idea
  after_save :update_stage_status

  REQUIRED_FIELDS = %w[
    startup_costs revenue_forecasts cost_forecasts break_even_analysis
    cash_flow_forecast funding_needs profit_and_loss risk_assessment kpi_milestones
  ].freeze

  def progress_percentage
    calculate_progress(REQUIRED_FIELDS)
  end

  def completed?
    progress_percentage == 100
  end

  def can_generate_ai?(section)
    return false unless REQUIRED_FIELDS.include?(section)

    # Ensure previous stages exist and have relevant data
    idea_def = business_idea.business_idea_definition
    market = business_idea.market_research
    competitors = business_idea.competitor_analysis&.last&.competitors

    case section
    when 'startup_costs', 'revenue_forecasts'
      idea_def.present? && market.present?
    when 'cost_forecasts'
      idea_def.present? && market.present? && competitors&.any?
    when 'break_even_analysis', 'cash_flow_forecast'
      revenue_forecasts.present? && cost_forecasts.present?
    when 'funding_needs'
      strategy = business_idea.strategy_development
      strategy.present? &&
        strategy.strategic_goals.present? &&
        strategy.core_strategy.present? &&
        strategy.core_strategy.include?("**Scaling Strategy:**")
    when 'profit_and_loss'
      revenue_forecasts.present? && cost_forecasts.present?
    when 'risk_assessment', 'kpi_milestones'
      strategy = business_idea.strategy_development
      idea_def.present? && strategy.present?
    else
      false
    end
  end

  private

  def update_stage_status
    stage = business_idea.stages.find_by(name: "Financial Planning")
    return unless stage

    stage.update(
      progress_percentage: progress_percentage,
      status: completed? ? :completed : :in_progress
    )
  end
end
