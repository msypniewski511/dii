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
    if business_idea.industry_type.nil? || business_idea.industry_type.name == "Unknown Industry"
      industry_name = OpenAI::AiIndustryClassifier.call(business_idea.description)
      industry = IndustryType.find_or_create_by(name: industry_name)
      business_idea.update!(industry_type: industry)
      business_idea.reload
    end
  end
end
