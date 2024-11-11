class CreateBrands < ActiveRecord::Migration[7.1]
  def change
    create_table :brands do |t|
      t.string :business_name
      t.string :website_domain

      t.timestamps
    end
  end
end
