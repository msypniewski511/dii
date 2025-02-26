class AddUserId < ActiveRecord::Migration[7.1]
  def change
    add_reference :brands, :user, index: true
    add_reference :business_ideas, :user, index: true
    add_reference :ideas, :user, index: true
  end
end
