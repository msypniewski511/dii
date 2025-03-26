class CreateFundingPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :funding_plans do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.text :bank_loan_borrowing
      t.text :alternative_funding

      t.timestamps
    end
  end
end
