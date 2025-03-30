# app/controllers/strategy_developments_controller.rb
class StrategyDevelopmentsController < ApplicationController
  before_action :set_business_idea
  before_action :set_strategy_development

  def edit; end

  def update
    if @strategy_development.update(strategy_params)
      redirect_to business_idea_path(@business_idea, anchor: 'strategy_development'), notice: "Strategy updated"
    else
      render :edit
    end
  end

  def generate_ai_section
    section = params[:field]
    missing_anchor = nil

    if @business_idea.business_idea_definition&.ai_summary.blank?
      missing_anchor = 'business_idea_definition'
    elsif @business_idea.market_research&.ai_suggestions.blank?
      missing_anchor = 'market_research'
    elsif @business_idea.competitor_analysis.blank? ||
          @business_idea.competitor_analysis.last.competitors.blank? ||
          @business_idea.competitor_analysis.last.competitors.any? { |c| c.five_forces.blank? }
      puts "KORWA W TYM KORESTWIE"
      p @business_idea.competitor_analysis.blank?
      p @business_idea.competitor_analysis.last.competitors.blank?
      p @business_idea.competitor_analysis.last.competitors.any?

      missing_anchor = 'competitor_analysis'
    end
  
    if missing_anchor
      redirect_to business_idea_path(@business_idea, anchor: missing_anchor), notice: "Strategy not updated. Missing required data in #{missing_anchor.humanize}."
    else
      puts "korwa czego brakuje"
      puts section
      puts @business_idea
      ai_text = OpenAI::AiStrategyDevelopmentService.generate(section, @business_idea)
      @strategy_development.update(section => ai_text.strip)
      redirect_to business_idea_path(@business_idea, anchor: 'strategy_development'), notice: "#{section.humanize} generated"
      # render json: { suggestion: ai_text }
    end
  end

  private

  def set_business_idea
    @business_idea = BusinessIdea.find(params[:business_idea_id])
  end

  def set_strategy_development
    @strategy_development = @business_idea.strategy_development || @business_idea.create_strategy_development
  end

  def strategy_params
    params.require(:strategy_development).permit(
      :vision, :mission, :strategic_goals, :core_strategy,
      :value_chain, :marketing_strategy, :competitive_strategy,
      :swot_actions, :kpis
    )
  end
end
