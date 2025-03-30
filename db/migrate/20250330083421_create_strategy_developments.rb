class CreateStrategyDevelopments < ActiveRecord::Migration[7.1]
  def change
    create_table :strategy_developments do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.text :vision
      t.text :mission
      t.text :strategic_goals
      t.text :core_strategy
      t.text :value_chain
      t.text :marketing_strategy
      t.text :competitive_strategy
      t.text :swot_actions
      t.text :kpis
      t.boolean :ai_generated
      t.json :ai_suggestions

      t.timestamps
    end
  end
end
