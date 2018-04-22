class Connection < ApplicationRecord
  has_one :recipe_part, as: :part
  has_one :recipe, through: :recipe_part

  belongs_to :child, class_name: 'Recipe', foreign_key: 'child_id'

  validates :child, presence: true
  validates :scale, presence: true

  def description
    self.recipe_part.description
  end

  def title
    self.recipe_part.title
  end

  def total
    self.child.total * self.scale.to_f
  end
end
