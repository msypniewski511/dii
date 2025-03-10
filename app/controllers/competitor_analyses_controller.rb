class CompetitorAnalysesController < ApplicationController
  before_action :set_business_idea

  def new
    @competitor_analysis = @business_idea.competitor_analysis.new
  end

  def create
    @competitor_analysis = @business_idea.competitor_analysis.build
  
    if @competitor_analysis.save
      # Fetch AI-generated competitors
      ai_competitors = OpenAI::OpenaiCompetitorService.find_competitors(@business_idea)
  
      ai_competitors.each do |comp|
        @competitor_analysis.competitors.create(
          name: comp["name"],
          description: comp["description"]
        )
      end
  
      redirect_to business_idea_path(@business_idea), notice: "Competitor Analysis generated successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  def show
    unless @business_idea.competitor_analysis.empty?
      @competitor_analysis = @business_idea.competitor_analysis.last
    else
      redirect_to new_business_idea_competitor_analyses_path(@business_idea)
    end
  end

  private

  def set_business_idea
    @business_idea = BusinessIdea.find(params[:business_idea_id])
  end
end
