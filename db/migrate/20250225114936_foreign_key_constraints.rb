class ForeignKeyConstraints < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key "brands", "users"
    add_foreign_key "business_ideas", "users"
  end
end
