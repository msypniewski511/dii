class CreatePorterFiveForces < ActiveRecord::Migration[7.1]
  def change
    create_table :porter_five_forces do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.integer :threat_of_new_entrants
      t.integer :supplier_power
      t.integer :buyer_power
      t.integer :threat_of_substitutes
      t.integer :industry_rivalry

      t.timestamps
    end
  end
end
