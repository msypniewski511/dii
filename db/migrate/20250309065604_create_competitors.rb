class CreateCompetitors < ActiveRecord::Migration[7.1]
  def change
    create_table :competitors do |t|
      t.references :competitor_analysis, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.text :five_forces

      t.timestamps
    end
  end
end
