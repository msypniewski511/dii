class PswotAnalysesController < ApplicationController
  before_action :authenticate_user!
  def new
    @swot = current_user.pswot_analyses.new
  end

  def create
    @swot = current_user.pswot_analyses.new(swot_params)
    
    if @swot.save
      response = analyze_swot(@swot)
      @swot.update(analysis: response)

      redirect_to home_personal_path
    else
      render :new
    end
  end

  def show
    @swot = current_user.pswot_analyses.find(params[:id])
    puts @swot.analysis
  end

  private

  def swot_params
    params.require(:pswot_analysis).permit(:strengths, :weaknesses, :opportunities, :threats)
  end

  def analyze_swot(swot)

    prompt = "Based on the following Personal SWOT analysis:
    - Strengths: #{swot.strengths}
    - Weaknesses: #{swot.weaknesses}
    - Opportunities: #{swot.opportunities}
    - Threats: #{swot.threats}

    Provide a detailed analysis including potential strategies for improvement.
    "
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-4",
        messages: [
          { role: "system", content: "You are a business analysis expert. Please provide" },
          { role: "user", content: prompt },
        ],
        max_tokens: 1500
      }
    ).dig("choices", 0, "message", "content")
    # response = OpenAI_API.call(prompt) # Replace with actual OpenAI integration
    puts response
    response
  end
end
