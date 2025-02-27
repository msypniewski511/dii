class SwotAnalysesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_swot_analysis, only: %i[ show edit update destroy ]

  # GET /swot_analyses or /swot_analyses.json
  def index
    @swot_analyses = SwotAnalysis.all
  end

  # GET /swot_analyses/1 or /swot_analyses/1.json
  def show
  end

  # GET /swot_analyses/new
  def new
    @swot_analysis = SwotAnalysis.new
  end

  # GET /swot_analyses/1/edit
  def edit
  end

  # POST /swot_analyses or /swot_analyses.json
  def create
    @swot_analysis = SwotAnalysis.new(swot_analysis_params)

    respond_to do |format|
      if @swot_analysis.save
        format.html { redirect_to business_idea_swot_analyses_path(@business_idea), notice: "Swot analysis was successfully created." }
        format.json { render :show, status: :created, location: @swot_analysis }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @swot_analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /swot_analyses/1 or /swot_analyses/1.json
  def update
    respond_to do |format|
      if params[:type]
        response = call_openai_api_params.dig("choices", 0, "message",  "content")
        @swot_analysis[params[:type].to_sym] = response
        @swot_analysis.save
        redirect_to business_idea_swot_analyses_path(@business_idea), notice: "Swot analysis was successfully updated."
        return
      end
      if @swot_analysis.update(swot_analysis_params)
        format.html { redirect_to business_idea_swot_analyses_path(@business_idea), notice: "Swot analysis was successfully updated." }
        format.json { render :show, status: :ok, location: @swot_analysis }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @swot_analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /swot_analyses/1 or /swot_analyses/1.json
  def destroy
    @swot_analysis.destroy!

    respond_to do |format|
      format.html { redirect_to swot_analyses_path, status: :see_other, notice: "Swot analysis was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_swot_analysis
      @business_idea = BusinessIdea.find(params[:business_idea_id])
      @swot_analysis = @business_idea.swot_analysis
    end

    # Only allow a list of trusted parameters through.
    def swot_analysis_params
      params.require(:swot_analysis).permit(:business_idea_id, :strengths, :weaknesses, :opportunities, :threats)
    end

    def call_openai_api_params
      puts "insilde openai call"
      @business_idea = @swot_analysis.business_idea
      client = OpenAI::Client.new
      client.chat(
        parameters: {
          model: "gpt-4",
          messages: [
            { role: "system", content: "You are a business analysis expert. Please provide" },
            { role: "user", content: "Analyze #{params[:type]} part and only this part of this business idea of SWOT frameworks and " },
            { role: "user", content: @business_idea.title },
            { role: "user", content: @business_idea.description },
            { role: "user", content: "Target Country: #{@business_idea.country}" },
            { role: "user", content: "Format your response in a clear and structured way." },
          ],
          max_tokens: 500
        }
      )
    end
end
