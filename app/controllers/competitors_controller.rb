class CompetitorsController < ApplicationController
  before_action :set_competitor_analysis, only: [:new, :create]
  before_action :set_competitor, only: [:update, :destroy]

  def new
    @competitor = Competitor.new
  end

  def create
    @competitor = @competitor_analysis.competitors.build(competitor_params)

    if @competitor.save
      redirect_to competitor_analysis_path(@competitor_analysis), notice: "Competitor added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @competitor.update(competitor_params)
      redirect_back_or_to competitor_analysis_path(@competitor.competitor_analysis), notice: "Competitor updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def ai_analysis
    # @business_idea = BusinessIdea.find(params[:business_idea_id])
    @competitor = Competitor.find(params[:business_idea_id])
    result = OpenAI::AiCompetitorAnalysis.do_analise(@competitor)
    @competitor.update(five_forces: result)
    # .competitor_analysis
    if !@competitor.competitor_analysis.competitors.any? {|c| c.five_forces.nil?} 
      update_stage_status 
    end
    redirect_back_or_to competitor_analyses_show_path(@competitor.competitor_analysis), notice: "Competitor updated."
  end

  def destroy
    @competitor.destroy
    redirect_to competitor_analysis_path(@competitor.competitor_analysis), notice: "Competitor removed."
  end

  private

  def set_competitor_analysis
    @competitor_analysis = CompetitorAnalysis.find(params[:competitor_analysis_id])
  end

  def set_competitor
    @competitor = Competitor.find(params[:id])
  end

  def competitor_params
    params.require(:competitor).permit(:name, :description, :five_forces)
  end

  def update_stage_status
    @business_idea = @competitor.competitor_analysis.business_idea
    stage = @business_idea.stages.find_by(name: "Competitor Analysis", stage_type: "nine_stages")
    stage.update(status: :completed) if stage.present?
  end
end
