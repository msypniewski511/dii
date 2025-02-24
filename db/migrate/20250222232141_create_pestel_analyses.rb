class CreatePestelAnalyses < ActiveRecord::Migration[7.1]
  def change
    create_table :pestel_analyses do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.text :political
      t.text :economic
      t.text :social
      t.text :technological
      t.text :environmental
      t.text :legal

      t.timestamps
    end
  end
end
