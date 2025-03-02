class CreatePortersFiveForces < ActiveRecord::Migration[7.1]
  def change
    create_table :porters_five_forces do |t|
      t.references :business_idea, null: false, foreign_key: true
      t.text :threat_of_new_entrants
      t.text :bargaining_power_of_suppliers
      t.text :bargaining_power_of_buyers
      t.text :threat_of_substitutes
      t.text :industry_rivalry
      t.text :analysis

      t.timestamps
    end
  end
end
