class OpenaiSuggestionsController < ApplicationController
  def create
    Rails.logger.info "Received parameters: #{params.inspect}"
    @business_idea = BusinessIdea.find_by(id: params[:id])

    unless @business_idea
      flash[:alert] = "Business idea not found."
      redirect_to business_ideas_path
      return
    end

    begin
      response = call_openai_api
      ai_suggestions = response.dig("choices", 0, "message", "content")

      if ai_suggestions.present?
        @business_idea.update(suggestions: ai_suggestions)
        @suggestions = ai_suggestions

        flash[:success] = "AI successfully generated suggestions!"
        redirect_to business_idea_path(@business_idea)
      else
        flash[:alert] = "AI returned an empty response. Please try again."
        redirect_to business_idea_path(@business_idea)
      end
    rescue StandardError => e
      Rails.logger.error "AI Error: #{e.message}"
      flash[:alert] = "Something went wrong with AI processing."
      redirect_to business_idea_path(@business_idea)
    end
  end

  private

  def call_openai_api
    client = OpenAI::Client.new
    client.chat(
      parameters: {
        model: "gpt-4",
        messages: [
          { role: "system", content: "You are a business analysis expert. Provide suggestions using PESTEL and SWOT frameworks." },
          { role: "user", content: "Analyze this business idea for #{@business_idea.country}." },
          { role: "user", content: "Title: #{@business_idea.title}" },
          { role: "user", content: "Description: #{@business_idea.description}" },
          { role: "user", content: "Give structured and practical recommendations." }
        ],
        max_tokens: 500
      }
    )
  end
end