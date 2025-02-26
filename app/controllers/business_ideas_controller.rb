class BusinessIdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business_idea, only: %i[ show edit update destroy ]


  # GET /business_ideas or /business_ideas.json
  def index
    @business_ideas = current_user.business_ideas
  end

  # GET /business_ideas/1 or /business_ideas/1.json
  def show
  end

  # GET /business_ideas/new
  def new
    @business_idea = current_user.business_ideas.build
    @business_idea.build_pestel_analysis
    @business_idea.build_swot_analysis
  end

  # GET /business_ideas/1/edit
  def edit
    @business_idea.build_pestel_analysis unless @business_idea.pestel_analysis
    @business_idea.build_swot_analysis unless @business_idea.swot_analysis
  end

  # POST /business_ideas or /business_ideas.json
  def create
    @business_idea = current_user.business_ideas.new(business_idea_params)

    respond_to do |format|
      if @business_idea.save
        format.html { redirect_to @business_idea, notice: "Business idea was successfully created." }
        format.json { render :show, status: :created, location: @business_idea }
      else
        Rails.logger.error "Business Idea Save Error: #{@business_idea.errors.full_messages}"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @business_idea.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_ideas/1 or /business_ideas/1.json
  def update
    respond_to do |format|
      if @business_idea.update(business_idea_params)
        format.html { redirect_to @business_idea, notice: "Business idea was successfully updated." }
        format.json { render :show, status: :ok, location: @business_idea }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @business_idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_ideas/1 or /business_ideas/1.json
  def destroy
    @business_idea.destroy!

    respond_to do |format|
      format.html { redirect_to business_ideas_path, status: :see_other, notice: "Business idea was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_idea
      @business_idea = current_user.business_ideas.find_by(id: params[:id])

      unless @business_idea
        flash[:alert] = "You are not authorized to access this business idea."
        redirect_to user_root_path # Redirects to sign-in page
      end
    end

    # Only allow a list of trusted parameters through.
    def business_idea_params
      params.require(:business_idea).permit(
        :title, :description, :country,
        pestel_analysis_attributes: [:political, :economic, :social, :technological, :environmental, :legal],
        swot_analysis_attributes: [:strengths, :weaknesses, :opportunities, :threats]
      )
    end
end
