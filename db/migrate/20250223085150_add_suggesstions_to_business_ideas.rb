class AddSuggesstionsToBusinessIdeas < ActiveRecord::Migration[7.1]
  def change
    add_column :business_ideas, :suggestions, :text
  end
end
