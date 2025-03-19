class AddProgressPercentageToStages < ActiveRecord::Migration[7.1]
  def change
    add_column :stages, :progress_percentage, :integer, default: 0
  end
end
