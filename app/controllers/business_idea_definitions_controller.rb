class BusinessIdeaDefinitionsController < ApplicationController
  before_action :set_business_idea
  before_action :set_definition

  def edit
    @business_idea = BusinessIdea.find(params[:business_idea_id])
    @business_idea_definition = @business_idea.business_idea_definition || @business_idea.create_business_idea_definition
  end
  

  def update
    if @definition.update(definition_params)
      # redirect_to edit_business_idea_definition_path(@business_idea), notice: "Saved"
      redirect_to edit_business_idea_business_idea_definition_path(@business_idea), notice: "#{params[:field] ? (field.humanize + 'generated') : 'Business idea definition updated'}"
    else
      render :edit
    end
  end

  def generate_ai_field
    field = params[:field]
    OpenAI::BusinessIdeaDefinitionGenerator.new(@definition).generate(field)
    # redirect_to edit_business_idea_definition_path(@business_idea), notice: "#{field.humanize} generated"
    # redirect_to edit_business_idea_business_idea_definition_path(@business_idea), notice: "#{field.humanize} generated"
    redirect_to business_idea_path(@business_idea, anchor: "business_idea_definition"), notice: "#{field.humanize} generated"
    # redirect_to business_idea_path(@business_idea, stage: 'business_idea_definition'), notice: "#{field.humanize} generated"
  end

  private

  def set_business_idea
    @business_idea = BusinessIdea.find(params[:business_idea_id])
  end

  def set_definition
    @definition = @business_idea.business_idea_definition || @business_idea.create_business_idea_definition
  end

  def definition_params
    params.require(:business_idea_definition).permit(
      :problem_statement, :solution, :target_audience, :market_size,
      :target_customer_segment, :value_proposition, :key_differentiators
    )
  end
end