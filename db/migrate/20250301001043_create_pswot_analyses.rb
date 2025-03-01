class CreatePswotAnalyses < ActiveRecord::Migration[7.1]
  def change
    create_table :pswot_analyses do |t|
      t.references :user, null: false, foreign_key: true
      t.text :strengths
      t.text :weaknesses
      t.text :opportunities
      t.text :threats
      t.text :analysis

      t.timestamps
    end
  end
end
