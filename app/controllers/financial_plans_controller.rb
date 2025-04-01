# app/controllers/financial_plans_controller.rb
class FinancialPlansController < ApplicationController
  before_action :set_business_idea
  before_action :set_financial_plan

  def show; end

  def edit; end

  def update
    if @financial_plan.update(financial_plan_params)
      # update_stage_status
      respond_to do |format|
        format.html { redirect_to business_idea_path(@business_idea, anchor: 'financial_planning'), notice: "Financial Plan updated!" }
        format.json { render json: { updated: true }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: { errors: @financial_plan.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def generate_ai_section
    section = params[:section]
    unless @financial_plan.can_generate_ai?(section)
      return redirect_to business_idea_path(@business_idea, anchor: 'financial_planning'), alert: "#{section.humanize} could not be generated due to missing context."
    end

    ai_text = OpenAI::FinancialPlanService.generate_section(section, @business_idea)

    if ai_text.present?
      @financial_plan.update(section => ai_text.strip, ai_generated: true)
      # update_stage_status
      render json: { suggestion: ai_text }
    else
      render json: { error: "AI failed to generate content." }, status: :unprocessable_entity
    end
  end

  private

  def set_business_idea
    @business_idea = BusinessIdea.find(params[:business_idea_id])
  end

  def set_financial_plan
    @financial_plan = @business_idea.financial_plan || @business_idea.create_financial_plan!
  end

  def financial_plan_params
    params.require(:financial_plan).permit(
      :startup_costs, :revenue_forecasts, :cost_forecasts, :break_even_analysis,
      :cash_flow_forecast, :funding_needs, :profit_and_loss, :risk_assessment, :kpi_milestones
    )
  end

  # def update_stage_status
  #   stage = @business_idea.stages.find_by(name: "Financial Planning", stage_type: "nine_stages")
  #   return unless stage

  #   stage.update(
  #     progress_percentage: @financial_plan.progress_percentage,
  #     status: @financial_plan.completed? ? :completed : :in_progress
  #   )
  # end
end
