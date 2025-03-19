class BusinessModelCanvasController < ApplicationController
  before_action :set_business_idea
  before_action :set_business_model_canva

  def show
  end

  def edit
    Rails.logger.info "Fetching AI suggestions..."
    ai_suggestions = OpenAI::GenerateBusinessModelCanvas.call(@business_idea)
    Rails.logger.info "AI Suggestions Received: #{ai_suggestions.inspect}"
  
    @suggestions = ai_suggestions.is_a?(Hash) ? ai_suggestions : {}
  
    # Merge AI suggestions with existing data
    merged_data = merge_bmc_with_ai_suggestions(@business_model_canva, @suggestions)
    Rails.logger.info "Final Merged Data: #{merged_data.inspect}"
  
    # ✅ Assign to form but don't save, so users can edit before saving
    @business_model_canva.assign_attributes(merged_data)
  end

  def update
    if @business_model_canva.update(business_model_canva_params)
      respond_to do |format|
        format.json { render json: { updated_text: @business_model_canva[params[:business_model_canva].keys.first] }, status: :ok }
        # format.json {}
        format.html { redirect_to business_idea_business_model_canva_path(@business_idea), notice: "Business Model Canva updated successfully!" }
      end
    else
      respond_to do |format|
        format.json { render json: { error: "Failed to update" }, status: :unprocessable_entity }
        format.html { render :edit }
      end
    end
  end

  def generate_ai_suggestion
    section = params[:section]
    user_input = params[:user_input]
    industry = @business_idea.industry_type.name
    competitor_analysis = @business_idea.competitor_analysis.first
    competitors = competitor_analysis&.competitors&.pluck(:name) || []
  
    ai_response = OpenAI::AiBusinessModelService.generate_suggestions(section, user_input, industry, competitors)
  
    @business_model_canva.update(ai_suggestions: @business_model_canva.ai_suggestions.merge({ section => ai_response }))
  
    render json: { suggestion: ai_response }
  end

  private

  def set_business_idea
    @business_idea = BusinessIdea.find(params[:business_idea_id])
  end

  def set_business_model_canva
    @business_model_canva = @business_idea.business_model_canva || @business_idea.create_business_model_canva
  end

  def business_model_canva_params
    params.require(:business_model_canva).permit(
      :key_partners, :key_activities, :key_resources, :value_propositions,
      :customer_relationships, :channels, :customer_segments, :cost_structure,
      :revenue_streams, :key_metrics, :customer_pains, :customer_gains,
      :cost_breakdown, :pricing_strategy, :distribution_channels, :partnerships
    )
  end

  def merge_bmc_with_ai_suggestions(bmc, suggestions)
    Rails.logger.info "BMC Before Merging: #{bmc.attributes.inspect}"
    Rails.logger.info "AI Suggestions Received: #{suggestions.inspect}"
  
    merged_data = {}
  
    # Iterate through each expected attribute in the BMC model
    suggestions.each do |key, ai_suggestion|
      # Ensure the key exists in the BMC model
      next unless bmc.has_attribute?(key)
  
      existing_value = bmc[key].to_s.strip.presence || "" # Existing data in BMC
      ai_suggestion = ai_suggestion.to_s.strip.presence || "" # AI suggestion
  
      # ✅ Merge AI suggestion only if it's present
      if ai_suggestion.present?
        merged_data[key] = if existing_value.present?
                             "#{existing_value}\n\n--- AI Suggestion ---\n#{ai_suggestion}"
                           else
                             ai_suggestion
                           end
      end
    end
  
    Rails.logger.info "Final Merged Data (Before Saving): #{merged_data.inspect}"
    merged_data
  end
end