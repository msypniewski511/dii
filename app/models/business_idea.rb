class BusinessIdea < ApplicationRecord
  belongs_to :industry_type, optional: true
  has_one :pestel_analysis, dependent: :destroy
  has_one :swot_analysis, dependent: :destroy
  has_one :porters_five_force, dependent: :destroy
  has_one :porter_five_force, dependent: :destroy

  has_one :business_idea_definition, dependent: :destroy
  has_one :market_research, dependent: :destroy
  has_one :business_model_canva, dependent: :destroy
  has_many :competitor_analysis

  has_many :stages, dependent: :destroy

  accepts_nested_attributes_for :pestel_analysis
  accepts_nested_attributes_for :swot_analysis

  belongs_to :user

  VALID_STATUSES = ["Draft", "In Progress", "Submitted", "Approved"]

  validates :title, :description, :country, presence: true
  validates :title, uniqueness: { scope: :user_id }
  validates :status, inclusion: { in: VALID_STATUSES }

  after_create :assign_industry
  after_create :assign_industry_and_create_analysis
  after_update :assign_industry_and_create_analysis
  after_update :recalculate_porter_five_forces, if: -> { saved_change_to_industry_type_id? }
  after_create :initialize_business_model_canvas


  private

  def assign_industry_and_create_analysis
    assign_industry if industry_type.nil? || industry_type.name == "Unknown Industry"
    
    create_porter_five_force! if porter_five_force.nil?
  end

  def recalculate_porter_five_forces
    porter_five_force.analyze_forces if porter_five_force.present?
  end

  def assign_industry
    industry_name = OpenAI::AiIndustryClassifier.call(self.description)
    industry = IndustryType.find_or_create_by(name: industry_name)
    self.update!(industry_type: industry)
  end

  def initialize_business_model_canvas
    create_business_model_canva!
  end
end