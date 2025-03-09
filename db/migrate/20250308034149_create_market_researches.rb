class CreateMarketResearches < ActiveRecord::Migration[7.1]
  def change
    create_table :market_researches do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.text :market_trends
      t.text :competitor_insights
      t.text :customer_segments
      t.text :industry_reports
      t.text :ai_suggestions

      t.timestamps
    end
  end
end
