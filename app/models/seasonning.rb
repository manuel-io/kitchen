class Seasonning < ApplicationRecord
  has_one :component, as: :adding
  has_one :recipe_part, through: :component
    
  validates :title, presence: true, uniqueness: true
  validates :amount, presence: true,  numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true,  numericality: { greater_than: 0 }
end
