class AddDeepFieldsToBusinessIdeaDefinitions < ActiveRecord::Migration[7.1]
  def change
    change_table :business_idea_definitions do |t|
      t.text :target_customer_segment
      t.text :value_proposition
      t.text :key_differentiators
      t.text :ai_summary
      t.boolean :ai_generated, default: false
      t.boolean :completed, default: false
    end
  end
end
