class FundingPlansController < ApplicationController
  before_action :set_funding_plan, only: %i[ show edit update destroy ]

  # GET /funding_plans or /funding_plans.json
  def index
    @funding_plans = FundingPlan.all
  end

  # GET /funding_plans/1 or /funding_plans/1.json
  def show
  end

  # GET /funding_plans/new
  def new
    @funding_plan = FundingPlan.new
  end

  # GET /funding_plans/1/edit
  def edit
  end

  # POST /funding_plans or /funding_plans.json
  def create
    @funding_plan = FundingPlan.new(funding_plan_params)

    respond_to do |format|
      if @funding_plan.save
        format.html { redirect_to @funding_plan, notice: "Funding plan was successfully created." }
        format.json { render :show, status: :created, location: @funding_plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @funding_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /funding_plans/1 or /funding_plans/1.json
  def update
    respond_to do |format|
      if @funding_plan.update(funding_plan_params)
        format.html { redirect_to @funding_plan, notice: "Funding plan was successfully updated." }
        format.json { render :show, status: :ok, location: @funding_plan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @funding_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funding_plans/1 or /funding_plans/1.json
  def destroy
    @funding_plan.destroy!

    respond_to do |format|
      format.html { redirect_to funding_plans_path, status: :see_other, notice: "Funding plan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def generate_ai
    @funding_plan = FundingPlan.find(params[:id])
    generator = OpenAI::FundingPlanGenerator.new(@funding_plan.business_idea)
  
    if params[:field] == "bank_loan"
      @funding_plan.bank_loan_borrowing = generator.bank_loan_borrowing
    elsif params[:field] == "alternative"
      @funding_plan.alternative_funding = generator.alternative_funding
    end
  
    if @funding_plan.save
      redirect_to @funding_plan, notice: "AI-generated answer saved."
    else
      redirect_to @funding_plan, alert: "AI generation failed."
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_funding_plan
      @funding_plan = FundingPlan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def funding_plan_params
      params.require(:funding_plan).permit(:business_idea_id, :bank_loan_borrowing, :alternative_funding)
    end
end
