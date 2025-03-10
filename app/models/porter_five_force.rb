class PorterFiveForce < ApplicationRecord
  belongs_to :business_idea

  before_create :ensure_industry_assigned
  after_create :analyze_forces


  def analyze_forces
    return if business_idea.industry_type.name == "Unknown Industry"

    analysis = OpenAI::AiPorterAnalysis.call(business_idea.industry_type) # AI scores 0-5
    puts "insite porter AI"
    puts analysis
    update!(analysis)
  end

  private

  def ensure_industry_assigned
    if business_idea.industry_type.name == "Unknown Industry"
      business_idea.assign_industry
      business_idea.reload # Ensure it updates before scoring
    end
  end
end
