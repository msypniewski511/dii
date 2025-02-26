class SetDefaultForIdea < ActiveRecord::Migration[7.1]
  def change 
    change_column_default :ideas, :status, 0
    change_column_default :ideas, :priority, 0
  end
end
