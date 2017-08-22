class Ingredient < ApplicationRecord
  belongs_to :product
  belongs_to :component
  validates :name, presence: true, length: { minimum: 2 }

  def amount
    super.to_s.sub(/\.0+/, '')
  end
end
