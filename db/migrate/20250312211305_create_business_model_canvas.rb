class CreateBusinessModelCanvas < ActiveRecord::Migration[7.1]
  def change
    create_table :business_model_canvas do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.text :key_partners
      t.text :key_activities
      t.text :key_resources
      t.text :value_propositions
      t.text :customer_relationships
      t.text :channels
      t.text :customer_segments
      t.text :cost_structure
      t.text :revenue_streams

      t.timestamps
    end
  end
end
