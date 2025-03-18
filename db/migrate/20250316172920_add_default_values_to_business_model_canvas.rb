class AddDefaultValuesToBusinessModelCanvas < ActiveRecord::Migration[7.1]
  def change
    change_column_default :business_model_canvas, :key_partners, ""
    change_column_default :business_model_canvas, :key_activities, ""
    change_column_default :business_model_canvas, :key_resources, ""
    change_column_default :business_model_canvas, :value_propositions, ""
    change_column_default :business_model_canvas, :customer_relationships, ""
    change_column_default :business_model_canvas, :channels, ""
    change_column_default :business_model_canvas, :customer_segments, ""
    change_column_default :business_model_canvas, :cost_structure, ""
    change_column_default :business_model_canvas, :revenue_streams, ""
    change_column_default :business_model_canvas, :key_metrics, ""
    change_column_default :business_model_canvas, :customer_pains, ""
    change_column_default :business_model_canvas, :customer_gains, ""
    change_column_default :business_model_canvas, :cost_breakdown, ""
    change_column_default :business_model_canvas, :pricing_strategy, ""
    change_column_default :business_model_canvas, :distribution_channels, ""
    change_column_default :business_model_canvas, :partnerships, ""
  end
end