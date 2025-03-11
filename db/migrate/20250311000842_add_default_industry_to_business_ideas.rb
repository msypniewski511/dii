class AddDefaultIndustryToBusinessIdeas < ActiveRecord::Migration[7.1]
  IndustryType.find_or_create_by(name: "Unknown Industry")
  def change
    change_column_default :business_ideas, :industry_type_id, IndustryType.find_by(name: "Unknown Industry")&.id
  end
end
