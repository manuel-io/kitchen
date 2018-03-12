class Component < ApplicationRecord
  has_one :recipe_part, as: :part
  has_one :recipe, through: :recipe_part
  has_many :ingredients, dependent: :destroy

  def title
    self.recipe_part.title
  end

  def description
    self.recipe_part.description
  end
end
