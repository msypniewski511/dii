class MarketResearchesController < ApplicationController
  before_action :set_business_idea
  before_action :set_market_research, only: [:edit, :update, :generate_ai_field]

  def new
    @market_research = @business_idea.build_market_research
  end

  def create
    @market_research = @business_idea.build_market_research(market_research_params)
    if @market_research.save
      # @market_research.generate_ai_field # AI Suggestions
      update_stage_status
      redirect_to business_idea_path(@business_idea, anchor: 'market_research'), notice: "Market Research added successfully!"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @market_research.update(market_research_params)
      # @market_research.generate_ai_field # AI Update
      # update_stage_status
      # redirect_to @business_idea, notice: "Market Research updated successfully!"
      redirect_to business_idea_path(@business_idea, anchor: 'market_research'), notice: "Market Research updated successfully!"
    else
      render :edit
    end
  end

  def generate_ai_field
    field = params[:field]
    @market_research.generate_ai_field(field)
    redirect_to business_idea_path(@business_idea, anchor: 'market_research'), notice: "#{field.humanize} generated"
  end

  private

  def set_business_idea
    @business_idea = BusinessIdea.find(params[:business_idea_id])
  end

  def set_market_research
    @market_research = @business_idea.market_research || @business_idea.build_market_research
    @market_research.save if @market_research.new_record?
  end

  def market_research_params
    params.require(:market_research).permit(:market_trends, :competitor_insights, :customer_segments, :industry_reports)
  end

  def update_stage_status
    stage = @business_idea.stages.find_by(name: "Market Research", stage_type: "nine_stages")
    stage.update(status: :completed) if stage.present?
  end
end
