class CreateStageMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :stage_methods do |t|
      t.integer :method_type
      t.references :stage, null: false, foreign_key: true
      t.jsonb :details

      t.timestamps
    end
  end
end
