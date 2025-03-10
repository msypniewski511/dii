class CreateBusinessIdeaDefinitions < ActiveRecord::Migration[7.1]
  def change
    create_table :business_idea_definitions do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.text :problem_statement
      t.text :solution
      t.text :target_audience
      t.text :market_size

      t.timestamps
    end
  end
end
