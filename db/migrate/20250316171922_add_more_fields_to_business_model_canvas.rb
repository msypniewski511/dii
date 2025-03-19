class AddMoreFieldsToBusinessModelCanvas < ActiveRecord::Migration[7.1]
  def change
    add_column :business_model_canvas, :key_metrics, :text
    add_column :business_model_canvas, :customer_pains, :text
    add_column :business_model_canvas, :customer_gains, :text
    add_column :business_model_canvas, :cost_breakdown, :text
    add_column :business_model_canvas, :pricing_strategy, :text
    add_column :business_model_canvas, :distribution_channels, :text
    add_column :business_model_canvas, :partnerships, :text
  end
end
