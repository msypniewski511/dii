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
    params.require(:business_model_canva).permit(
      :key_partners, :key_activities, :key_resources, :value_propositions,
      :customer_relationships, :channels, :customer_segments, :cost_structure,
      :revenue_streams, :key_metrics, :customer_pains, :customer_gains,
      :cost_breakdown, :pricing_strategy, :distribution_channels, :partnerships
    )
  end


  # def merge_bmc_with_ai_suggestions(bmc, suggestions)
  #   return {} if bmc.nil? || suggestions.nil? # Ensure neither is nil
  
  #   merged_data = {}
  
  #   bmc.attributes.each do |key, value|
  #     next unless suggestions.key?(key.to_sym) # Ensure key exists in AI suggestions
  
  #     existing_value = value.to_s.strip
  #     ai_suggestion = suggestions[key.to_sym].to_s.strip
  
  #     # 🔥 Append AI suggestion below existing content
  #     if existing_value.present? && ai_suggestion.present?
  #       merged_data[key] = "#{existing_value}\n\n--- AI Suggestion ---\n#{ai_suggestion}"
  #     else
  #       merged_data[key] = existing_value.presence || ai_suggestion
  #     end
  #   end
  
  #   Rails.logger.info "Merged Business Model Canvas Data: #{merged_data.inspect}"
  #   merged_data # ✅ We return the merged data but don't auto-save it
  # end
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

# class BusinessModelCanvasController < ApplicationController
#   before_action :set_business_idea
#   before_action :set_business_model_canvas

#   def show
#   end

#   def edit
#     puts "Cnva model: "
#     puts @business_model_canvas
#     puts "OpenAI:"
#     # @suggestions = OpenAI::GenerateBusinessModelCanvas.call(@business_idea)
#     # Rails.logs.info @suggestions
#     # @suggestions =  merge_bmc_with_ai_suggestions(@business_model_canvas, @suggestions)
#     @suggestions = @business_model_canvas
#     puts @suggestions
#   end

#   def update
#     if @business_model_canvas.update(business_model_canvas_params)
#       redirect_to business_idea_business_model_canvas_path(@business_idea), notice: "Business Model Canvas updated successfully!"
#     else
#       render :edit
#     end
#   end

#   private

#   def set_business_idea
#     @business_idea = BusinessIdea.find(params[:business_idea_id])
#   end

#   def set_business_model_canvas
#     @business_model_canvas = @business_idea.business_model_canva || @business_idea.create_business_model_canva
#   end

#   def business_model_canvas_params
#     params.require(:business_model_canvas).permit(:key_partners, :key_activities, :key_resources, :value_propositions, :customer_relationships, :channels, :customer_segments, :cost_structure, :revenue_streams)
#   end

#   def merge_bmc_with_ai_suggestions(bmc, suggestions)
#     merged_data = {}
  
#     bmc.attributes.each do |key, value|
#       next unless suggestions.key?(key)
  
#       existing_value = value.to_s.strip
#       ai_suggestion = suggestions[key].to_s.strip
  
#       # Merge with a separator if there's an existing value
#       merged_data[key] = if existing_value.present? && ai_suggestion.present?
#                            "#{existing_value}\n\n--- AI Suggestion ---\n\n#{ai_suggestion}"
#                          else
#                            existing_value.presence || ai_suggestion
#                          end
#     end
  
#     # bmc.update(merged_data) # Save merged data back to the database
#   end
# end