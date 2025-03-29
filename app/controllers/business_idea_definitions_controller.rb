# class BusinessIdeaDefinitionsController < ApplicationController
#   before_action :set_business_idea
#   before_action :set_business_idea_definition, only: [:edit, :update]

#   def new
#     @business_idea_definition = @business_idea.build_business_idea_definition
#   end

#   def create
#     @business_idea_definition = @business_idea.build_business_idea_definition(business_idea_definition_params)

#     if @business_idea_definition.save
#       @business_idea_definition.generate_ai_suggestions
#       flash[:notice] = "Business Idea Definition saved successfully!"
#       redirect_to @business_idea
#     else
#       flash[:alert] = "There were errors saving the form."
#       render :new
#     end
#   end

#   def edit
#   end

#   def update
#     if @business_idea_definition.update(business_idea_definition_params)
#       @business_idea_definition.generate_ai_suggestions if @business_idea_definition.ai_suggestions.nil?
#       flash[:notice] = "Business Idea Definition updated successfully!"
#       redirect_to @business_idea
#     else
#       flash[:alert] = "There were errors updating the form."
#       render :edit
#     end
#   end

#   private

#   def set_business_idea
#     @business_idea = BusinessIdea.find(params[:business_idea_id])
#   end

#   def set_business_idea_definition
#     puts "tuttaj"
#     puts @business_idea
#     puts "----------------------------"
#     @business_idea_definition = @business_idea.business_idea_definition || @business_idea.build_business_idea_definition
#     puts "check business definitition"
#     puts @business_idea_definition
#   end

#   def business_idea_definition_params
#     params.require(:business_idea_definition).permit(:problem_statement, :solution, :target_audience, :market_size)
#   end



#   def call_openai_api_params
#     puts "insilde openai call"
#     client = OpenAI::Client.new
#     client.chat(
#       parameters: {
#         model: "gpt-4",
#         messages: [
#           { role: "system", content: "You are a business analysis expert. Please provide" },
#           { role: "user", content: "Analyze: 1. problem_statement, 2. solution, 3. target_audience, 4. market_size for this business idea" },
#           { role: "user", content: " business title: #{@business_idea.title}" },
#           { role: "user", content: " business description: #{@business_idea.description}" },
#           { role: "user", content: "Target Country: #{@business_idea.country}" },
#           { role: "user", content: "Format your response in a clear and structured way." },
#         ],
#         max_tokens: 1000
#       }
#     )
#   end
# end


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