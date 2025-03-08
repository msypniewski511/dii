class StageMethod < ApplicationRecord
  belongs_to :stage

  enum method_type: { 
    nine_stages: 0, 
    lean_startup: 1, 
    business_model_canvas: 2, 
    bozward_model: 3 # Added Bozward's model
  }

  validates :method_type, presence: true
end
