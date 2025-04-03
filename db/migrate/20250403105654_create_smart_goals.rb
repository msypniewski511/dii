class CreateSmartGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :smart_goals do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.string :category, null: false
      t.date :start_date
      t.date :due_date
      t.boolean :milestone, default: false

      t.timestamps
    end
  end
end
