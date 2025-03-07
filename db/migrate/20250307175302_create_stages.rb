class CreateStages < ActiveRecord::Migration[7.1]
  def change
    create_table :stages do |t|
      t.string :name
      t.integer :stage_type
      t.references :business_idea, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
