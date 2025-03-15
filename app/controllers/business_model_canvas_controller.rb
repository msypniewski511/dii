class BusinessModelCanvasController < ApplicationController
  before_action :set_business_idea
  before_action :set_business_model_canva

  def show
  end

  def edit
    @suggestions = OpenAI::GenerateBusinessModelCanvas.call(@business_idea)
    render :edit
  end

  def update
    if @business_model_canva.update(business_model_canva_params)
      redirect_to business_idea_business_model_canva_path(@business_idea), notice: "Business Model Canva updated successfully!"
    else
      render :edit
    end
  end

  private

  def set_business_idea
    @business_idea = BusinessIdea.find(params[:business_idea_id])
  end

  def set_business_model_canva
    @business_model_canva = @business_idea.business_model_canva || @business_idea.create_business_model_canva
  end

  def business_model_canva_params
    params.require(:business_model_canva).permit(:key_partners, :key_activities, :key_resources, :value_propositions, :customer_relationships, :channels, :customer_segments, :cost_structure, :revenue_streams)
  end
end
