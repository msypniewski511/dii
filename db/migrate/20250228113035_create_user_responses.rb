class CreateUserResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :user_responses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
