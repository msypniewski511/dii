class PestelAnalysesController < ApplicationController
  before_action :set_pestel_analysis, only: %i[ show edit update destroy ]

  # GET /pestel_analyses or /pestel_analyses.json
  def index
    @pestel_analyses = PestelAnalysis.all
  end

  # GET /pestel_analyses/1 or /pestel_analyses/1.json
  def show
    @busines_idea = @pestel_analysis.business_idea
  end

  # GET /pestel_analyses/new
  def new
    @pestel_analysis = PestelAnalysis.new
  end

  # GET /pestel_analyses/1/edit
  def edit
  end

  # POST /pestel_analyses or /pestel_analyses.json
  def create
    @pestel_analysis = PestelAnalysis.new(pestel_analysis_params)

    respond_to do |format|
      if params[:type]
        response = call_openai_api_params
        @pestel_analysis = PestelAnalysis.new(params[:type].to_sym :resonse, pestel_analysis_params)
      end
      if @pestel_analysis.save
        format.html { redirect_to @pestel_analysis, notice: "Pestel analysis was successfully created." }
        format.json { render :show, status: :created, location: @pestel_analysis }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pestel_analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pestel_analyses/1 or /pestel_analyses/1.json
  def update
    respond_to do |format|
      if params[:type]
        puts "Object 1"
        p @pestel_analysis
        response = call_openai_api_params.dig("choices", 0, "message",  "content")
        puts response
        # @pestel_analysis.political = response
        @pestel_analysis[params[:type].to_sym] = response
        
        puts "Object 2"
        p @pestel_analysis
        @pestel_analysis.save
        redirect_to @pestel_analysis, notice: "Pestel analysis was successfully updated."
        return 
      end
      if @pestel_analysis.update(pestel_analysis_params)
        format.html { redirect_to @pestel_analysis, notice: "Pestel analysis was successfully updated." }
        format.json { render :show, status: :ok, location: @pestel_analysis }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pestel_analysis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pestel_analyses/1 or /pestel_analyses/1.json
  def destroy
    @pestel_analysis.destroy!

    respond_to do |format|
      format.html { redirect_to pestel_analyses_path, status: :see_other, notice: "Pestel analysis was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pestel_analysis
      @pestel_analysis = PestelAnalysis.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pestel_analysis_params
      params.require(:pestel_analysis).permit(:business_idea_id, :political, :economic, :social, :technological, :environmental, :legal)
    end

    def call_openai_api_params
      puts "insilde openai call"
      @business_idea = @pestel_analysis.business_idea
      client = OpenAI::Client.new
      client.chat(
        parameters: {
          model: "gpt-4",
          messages: [
            { role: "system", content: "You are a business analysis expert. Please provide" },
            { role: "user", content: "Analyze #{params[:type]} part and only this part of this business idea of PESTEL frameworks and " },
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
