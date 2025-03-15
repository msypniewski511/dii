
class BusinessModelCanvaController < ApplicationController
  before_action :set_business_idea
  before_action :set_business_model_canvas

  def show
  end

  def edit
    @suggestions = OpenAI::GenerateBusinessModelCanvas.call(@business_idea)
    @suggestions =  merge_bmc_with_ai_suggestions(@business_model_canvas, @suggestions)
  end

  def update
    if @business_model_canvas.update(business_model_canvas_params)
      redirect_to business_idea_business_model_canvas_path(@business_idea), notice: "Business Model Canvas updated successfully!"
    else
      render :edit
    end
  end

  private

  def set_business_idea
    @business_idea = BusinessIdea.find(params[:business_idea_id])
  end

  def set_business_model_canvas
    @business_model_canvas = @business_idea.business_model_canva || @business_idea.create_business_model_canva
  end

  def business_model_canvas_params
    params.require(:business_model_canvas).permit(:key_partners, :key_activities, :key_resources, :value_propositions, :customer_relationships, :channels, :customer_segments, :cost_structure, :revenue_streams)
  end

  def merge_bmc_with_ai_suggestions(bmc, suggestions)
    merged_data = {}
  
    bmc.attributes.each do |key, value|
      next unless suggestions.key?(key)
  
      existing_value = value.to_s.strip
      ai_suggestion = suggestions[key].to_s.strip
  
      # Merge with a separator if there's an existing value
      merged_data[key] = if existing_value.present? && ai_suggestion.present?
                           "#{existing_value}\n\n--- AI Suggestion ---\n\n#{ai_suggestion}"
                         else
                           existing_value.presence || ai_suggestion
                         end
    end
  
    # bmc.update(merged_data) # Save merged data back to the database
  end
end
