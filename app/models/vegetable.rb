class Vegetable < ApplicationRecord
  has_one :component, as: :adding
  has_one :recipe_part, through: :component

  validates :title, presence: true, uniqueness: true
  validates :amount, presence: true,  numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true,  numericality: { greater_than: 0 }
end

def amount
  1000
end

def unit
  :g
end
