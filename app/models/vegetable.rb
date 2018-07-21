class Vegetable < ApplicationRecord
   has_many :ingredients, as: :adding

  validates :title, presence: true, uniqueness: true
  validates :price, presence: true,  numericality: { greater_than: 0 }

  def amount
    1000
  end

  def manufacturer
   "Ø"
  end

  def shop
    "Ø"
  end

  def unit
    :g
  end
end
