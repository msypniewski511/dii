class CreateCompetitorAnalyses < ActiveRecord::Migration[7.1]
  def change
    create_table :competitor_analyses do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.text :summary

      t.timestamps
    end
  end
end
