class OpenaiSuggestionsController < ApplicationController
  def create
    Rails.logger.info "Received parameters: #{params.inspect}"
    @business_idea = BusinessIdea.find(params[:id])
  
    if @business_idea.nil?
      render json: { error: "Business idea not found" }, status: :unprocessable_entity
      return
    end
    @business_idea = BusinessIdea.find(params[:id])
    prompt = build_prompt(@business_idea)

    client = OpenAI::Client.new
    begin
      response = call_openai_api
      if response["error"]
        @suggestions = response["error"]["message"]
        render "business_ideas/show"
        # render json: { error: response["error"]["message"] }, status: :unprocessable_entity
      else
        suggestions = response.dig("choices", 0, "text")
        @suggestions = suggestions
        # Render the business idea's show view with the suggestions available
        @business_idea.update(suggestions: response["choices"].first["message"]["content"])
        @business_idea.reload
        render "business_ideas/show"
        # render json: { suggestions: @business_idea.suggestions }
      end


    rescue StandardError => e
      Rails.logger.error "AI Error: #{e.message}"
      render json: { error: "AI analysis failed. Please try again." }, status: :unprocessable_entity
    end
  end

  private

  def call_openai_api
    client = OpenAI::Client.new
    client.chat(
      parameters: {
        model: "gpt-4",
        messages: [
          { role: "system", content: "You are a business analysis expert. Please provide" },
          { role: "user", content: "Analyze detailed this business idea using PESTEL and SWOT frameworks. Target Country: #{@business_idea.country}." },
          { role: "user", content: @business_idea.title },
          { role: "user", content: @business_idea.description },
          { role: "user", content: "Format your response in a clear and structured way." },
        ],
        max_tokens: 500
      }
    )
  end

  # Build a prompt that includes both the PESTEL and SWOT context
  def build_prompt(business_idea)
    <<~PROMPT
      You are a business analysis expert. Analyze the following business idea by providing practical suggestions and detailed analysis using the PESTEL and SWOT frameworks.

      Business Idea Title: #{@business_idea.title}
      Description: #{@business_idea.description}
      Target Country: USA

      Please provide:
      - A detailed PESTEL analysis (Political, Economic, Social, Technological, Environmental, Legal factors).
      - A comprehensive SWOT analysis (Strengths, Weaknesses, Opportunities, Threats).

      Format your response in a clear and structured way.
    PROMPT
  end
end
