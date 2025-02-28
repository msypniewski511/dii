class CreateEntrepreneurialSkillsUserResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :entrepreneurial_skills_user_responses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true
      t.datetime :time

      t.timestamps
    end
  end
end
