class Brand < ApplicationRecord
  has_rich_text :strapline
  has_rich_text :colours_fonts
  has_rich_text :consistency
  has_rich_text :workwear
  has_rich_text :values
  has_rich_text :mision_statement
  validates :business_name, presence: true

  belongs_to :user
end
