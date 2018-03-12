class Ingredient < ApplicationRecord
  belongs_to :product, -> (ing) do
    if ing.unit == 'ml'
      where("liquid = 'true'")
    else
      where("liquid = 'false'")
    end
  end

  belongs_to :component

  validates :product, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :unit, presence: true
  validates_inclusion_of :unit, in: %w|g ml x TL EL|
  validates :title, presence: true

  def amount
    super.to_s.sub(/\.0+/, '')
  end
end
