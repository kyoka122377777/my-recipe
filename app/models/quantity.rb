class Quantity < ApplicationRecord
  belongs_to :recipe
  validates :ingredient_name, presence: true
  validates :amount_with_unit, presence: true
end
  