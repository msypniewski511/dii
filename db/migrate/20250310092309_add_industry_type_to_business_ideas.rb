class AddIndustryTypeToBusinessIdeas < ActiveRecord::Migration[7.1]
  def change
    # Step 1: Add the column without NOT NULL constraint
    add_reference :business_ideas, :industry_type, foreign_key: true, null: true

    # Step 2: Populate existing records with a default industry
    default_industry = IndustryType.find_or_create_by(name: "Unknown Industry")
    BusinessIdea.where(industry_type_id: nil).update_all(industry_type_id: default_industry.id)

    # Step 3: Change to NOT NULL after all records are updated
    change_column_null :business_ideas, :industry_type_id, false
  end
end
