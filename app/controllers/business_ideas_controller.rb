class BusinessIdeasController < ApplicationController
  before_action :authenticate_user!
  before_action :require_business_owner_characteristics, only: [:new, :create]
  before_action :set_business_idea, only: %i[ show edit update destroy ]


  # GET /business_ideas or /business_ideas.json
  def index
    @business_ideas = current_user.business_ideas
  end

  # GET /business_ideas/1 or /business_ideas/1.json
  def show
    @porter_analysis = @business_idea.porter_five_force || @business_idea.build_porter_five_force
    @porters_five_force = @business_idea.porters_five_force || @business_idea.build_porters_five_force
    @pestel_analysis = @business_idea.pestel_analysis || @business_idea.build_pestel_analysis
    @swot_analysis = @business_idea.swot_analysis || @business_idea.build_swot_analysis
    @business_idea_definition = @business_idea.business_idea_definition || @business_idea.build_business_idea_definition
    @market_research = @business_idea.market_research || @business_idea.build_market_research
    @competitor_analysis = @business_idea.competitor_analysis.last || @business_idea.competitor_analysis.build
    @business_model_canva = @business_idea.business_model_canva || @business_idea.create_business_model_canva
  end

  # GET /business_ideas/new
  def new
    @business_idea = current_user.business_ideas.build
    @business_idea.stages.new(stage_type: :nine_stages) # Default selection only for new forms
    @business_idea.build_pestel_analysis
    @business_idea.build_swot_analysis
  end

  def create
    @business_idea = current_user.business_ideas.new(business_idea_params)
    respond_to do |format|
      if @business_idea.save
        
        @business_idea.create_pestel_analysis!
        @business_idea.create_swot_analysis!
        # Assign 'nine_stages' by default ONLY if no models are selected
        selected_models = params[:selected_models] || []
        selected_models << "nine_stages" if selected_models.empty?
        BusinessLogic::StageCreationService.create_stages_for_business_idea(@business_idea, selected_models)
        update_nine_stages_progress

        format.html { redirect_to @business_idea, notice: "Business idea was successfully created." }
        format.json { render :show, status: :created, location: @business_idea }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @business_idea.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end
  

  # GET /business_ideas/1/edit
  def edit
    @business_idea.build_pestel_analysis unless @business_idea.pestel_analysis
    @business_idea.build_swot_analysis unless @business_idea.swot_analysis
    @business_idea.build_porters_five_force unless @business_idea.porters_five_force
    @selected_models = @business_idea.stages.distinct.pluck(:stage_type) # Load previously selected models
  end


  # PATCH/PUT /business_ideas/1 or /business_ideas/1.json
  def update
    respond_to do |format|
      if @business_idea.update(business_idea_params)
        selected_models = params[:selected_models] || []
        BusinessLogic::StageCreationService.create_stages_for_business_idea(@business_idea, selected_models)
        update_nine_stages_progress
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
        flash[:alert] = "Business idea not found or unauthorized."
        redirect_to business_ideas_path
      end
    end

    # Only allow a list of trusted parameters through.
    def business_idea_params
      params.require(:business_idea).permit(
        :title, :description, :country, :status, :industry_type_id,
        pestel_analysis_attributes: [:political, :economic, :social, :technological, :environmental, :legal],
        swot_analysis_attributes: [:strengths, :weaknesses, :opportunities, :threats]
      )
    end

    def require_business_owner_characteristics
      unless business_owner_characteristics_completed?
        flash[:alert] = "You need to complete your Business Owner Characteristics."
        
        unless current_user.assessments.exists?
          flash[:alert] << " You need to complete Your Entrepreneurial Skill Analysis with AI first."
          return redirect_to new_assessment_path
        end
    
        unless current_user.pswot_analyses.exists?
          flash[:alert] << " You need to complete Your SWOT Analysis with AI."
          return redirect_to new_pswot_analysis_path
        end
        User.last.business_ideas.any? {|idea| idea.stages.any? { |stage| stage.stage_type == "nine_stages" }}
      end
    end
  
    def using_nine_stages_model?
      @business_idea.stages.any? { |stage| stage.stage_type == "nine_stages" }
    end
    
    def business_owner_characteristics_completed?
      current_user.assessments.exists? && current_user.pswot_analyses.exists?
    end

    # def using_nine_stages_model?
    #   puts "checking #{current_user.business_ideas.any? { |idea| idea.selected_models.include?("nine_stages") }}"
    #   current_user.business_ideas.any? { |idea| idea.selected_models.include?("nine_stages") }
    # end

    def update_nine_stages_progress
      if using_nine_stages_model?
        stage = Stage.find_by(name: "Business Owner Characteristics", stage_type: "nine_stages", business_idea: @business_idea)
        p stage
        stage.update(status: "completed") if stage.present?
        p stage
      end
    end


    def calculate_progress(model, fields)
      return 0 if model.nil?
      total_fields = fields.size
      completed_fields = fields.count { |field| model[field].present? }
      progress = (completed_fields.to_f / total_fields * 100).round
      Rails.logger.info "Progress for #{model.class.name}: #{progress}%"
      progress
    end
end
