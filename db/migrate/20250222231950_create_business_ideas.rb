class CreateBusinessIdeas < ActiveRecord::Migration[7.1]
  def change
    create_table :business_ideas do |t|
      t.string :title
      t.text :description
      t.string :country

      t.timestamps
    end
  end
end
