class CreateFinancialPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :financial_plans do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.text :startup_costs
      t.text :revenue_forecasts
      t.text :cost_forecasts
      t.text :break_even_analysis
      t.text :cash_flow_forecast
      t.text :funding_needs
      t.text :profit_and_loss
      t.text :risk_assessment
      t.text :kpi_milestones
      t.boolean :ai_generated, default: false
      t.integer :progress_percentage, default: 0

      t.timestamps
    end
  end
end
