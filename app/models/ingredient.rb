class Ingredient < ApplicationRecord
  belongs_to :product, -> (ing) do
    if ing.unit == 'ml'
      where("liquid = 'true'")
    else
      where("liquid = 'false'")
    end
  end
  belongs_to :component
  validates :name, presence: true, length: { minimum: 2 }

  def amount
    super.to_s.sub(/\.0+/, '')
  end
end
