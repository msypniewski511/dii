class CreateIdeas < ActiveRecord::Migration[7.1]
  def change
    create_table :ideas do |t|
      t.date :due_date
      t.integer :priority
      t.string :action_point
      t.integer :status
      t.boolean :added_to_business_plan

      t.timestamps
    end
  end
end
