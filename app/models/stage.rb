class Stage < ApplicationRecord
  belongs_to :business_idea
  has_many :stage_methods, dependent: :destroy

  enum stage_type: { 
    nine_stages: 0, 
    lean_startup: 1, 
    business_model_canvas: 2, 
    bozward_model: 3 # Added Bozward's model
  }

  enum status: { 
    not_started: 0, 
    in_progress: 1, 
    completed: 2 
  }

  validates :name, presence: true

  def completed?
    status == "completed"
  end

  # Update status automatically based on AI insights
  def update_status(new_status)
    update(status: new_status)
  end

  STAGE_ORDERS = {
    "nine_stages" => [
      "Business Owner Characteristics",
      "Business Idea Definition",
      "Market Research",
      "Competitor Analysis",
      "Business Model Definition",
      "Strategy Development",
      "Financial Planning",
      "Legal & Operations",
      "Business Plan Finalization"
    ],
    "lean_startup" => [
      "Build MVP",
      "Measure & Learn",
      "Validate Idea",
      "Pivot if Necessary",
      "Customer Feedback Loop",
      "Iterations",
      "Growth Hacking",
      "Scaling Strategies",
      "Expansion"
    ],
    "business_model_canvas" => [
      "Key Partners",
      "Key Activities",
      "Value Propositions",
      "Customer Segments",
      "Channels",
      "Revenue Streams",
      "Cost Structure",
      "Customer Relationships",
      "Key Resources"
    ],
    "bozward_model" => [
      "Discovery",
      "Modeling",
      "Startup",
      "Existence",
      "Survival",
      "Success",
      "Adaptation",
      "Independence",
      "Exit"
    ]
  }

  scope :ordered, ->(stage_type) {
    order(:created_at).to_a.sort_by { |stage| STAGE_ORDERS[stage_type]&.index(stage.name) || STAGE_ORDERS[stage_type]&.length || 100 }
  }
end
