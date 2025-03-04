class PortersFiveForcesController < ApplicationController
  before_action :set_business_idea
  before_action :set_porters_five_force, only: [:edit, :update, :show, :generate_ai_analysis]

  def new
    @porters_five_force = @business_idea.build_porters_five_force
  end

  def create
    @porters_five_force = @business_idea.build_porters_five_force(porters_five_force_params)
    if @porters_five_force.save
      redirect_to @business_idea, notice: "Porter's Five Forces analysis added successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @porters_five_force.update(porters_five_force_params)
      redirect_to @business_idea, notice: "Analysis updated."
    else
      render :edit
    end
  end

  def generate_ai_analysis
    @porters_five_force = @business_idea.porters_five_force || @business_idea.build_porters_five_force
    @porters_five_force.save if @porters_five_force.new_record?


    client = OpenAI::Client.new

    prompt = <<~PROMPT
      Analyze the business idea "#{@business_idea.title}" in #{@business_idea.country} with business description #{@business_idea.description} using Porter's Five Forces:
      
      1. Threat of New Entrants
      2. Bargaining Power of Suppliers
      3. Bargaining Power of Buyers
      4. Threat of Substitutes
      5. Industry Rivalry
      
      Provide a detailed analysis for each force. 
      Format your response in a clear and structured way.
      Return formated text to display on webpage please.
    PROMPT

    response = client.chat(
      parameters: {
        model: "gpt-4",
        messages: [{ role: "system", content: "You are an expert business analyst." }, { role: "user", content: prompt }],
        temperature: 0.7
      }
    )

    ai_analysis = response.dig("choices", 0, "message", "content")
    Rails.logger.info("AI: #{ai_analysis}")
    puts ai_analysis

    if ai_analysis.present?
      sections = ai_analysis.split("\n\n")

      @porters_five_force.update!(
        threat_of_new_entrants: sections[0] || "No data available",
        bargaining_power_of_suppliers: sections[1] || "No data available",
        bargaining_power_of_buyers: sections[2] || "No data available",
        threat_of_substitutes: sections[3] || "No data available",
        industry_rivalry: sections[4] || "No data available",
        analysis: sections.join("\n\n")
      )
      redirect_to @business_idea, notice: "AI-generated analysis added successfully."
    else
      redirect_to @business_idea, alert: "Failed to generate AI analysis."
    end
  end

  private

  def set_business_idea
    @business_idea = BusinessIdea.find(params[:business_idea_id])
  end

  def set_porters_five_force
    @porters_five_force = @business_idea.porters_five_force
  end

  def porters_five_force_params
    params.require(:porters_five_force).permit(:threat_of_new_entrants, :bargaining_power_of_suppliers, 
                                               :bargaining_power_of_buyers, :threat_of_substitutes, 
                                               :industry_rivalry, :analysis)
  end
end
