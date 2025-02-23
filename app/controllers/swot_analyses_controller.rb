class SwotAnalysesController < ApplicationController
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
        format.html { redirect_to @swot_analysis, notice: "Swot analysis was successfully created." }
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
      if @swot_analysis.update(swot_analysis_params)
        format.html { redirect_to @swot_analysis, notice: "Swot analysis was successfully updated." }
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
      @swot_analysis = SwotAnalysis.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def swot_analysis_params
      params.require(:swot_analysis).permit(:business_idea_id, :strengths, :weaknesses, :opportunities, :threats)
    end
end
