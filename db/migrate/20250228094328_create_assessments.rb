class CreateAssessments < ActiveRecord::Migration[7.1]
  def change
    create_table :assessments do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :total_score
      t.string :level
      t.text :ai_insights

      t.timestamps
    end
  end
end
