class AddAiSuggestionsToBusinessIdeaDefinitions < ActiveRecord::Migration[7.1]
  def change
    add_column :business_idea_definitions, :ai_suggestions, :text
  end
end
