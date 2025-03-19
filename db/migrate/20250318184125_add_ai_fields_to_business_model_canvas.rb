class AddAiFieldsToBusinessModelCanvas < ActiveRecord::Migration[7.1]
  def change
    add_column :business_model_canvas, :ai_suggestions, :jsonb, default: {}
    add_column :business_model_canvas, :user_input, :jsonb, default: {}
    add_column :business_model_canvas, :industry_insights, :jsonb, default: {}
    add_column :business_model_canvas, :competitor_insights, :jsonb, default: {}

    # Optional: Add indexes for performance (use GIN index for JSONB)
    add_index :business_model_canvas, :ai_suggestions, using: :gin
    add_index :business_model_canvas, :user_input, using: :gin
    add_index :business_model_canvas, :industry_insights, using: :gin
    add_index :business_model_canvas, :competitor_insights, using: :gin
  end
end
