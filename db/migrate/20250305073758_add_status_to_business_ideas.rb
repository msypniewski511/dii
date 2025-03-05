class AddStatusToBusinessIdeas < ActiveRecord::Migration[7.1]
  def change
    add_column :business_ideas, :status, :string, default: "Draft"
  end
end
