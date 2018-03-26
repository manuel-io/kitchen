class Connection < ApplicationRecord
  has_one :recipe_part, as: :part
  has_one :recipe, through: :recipe_part

  belongs_to :child, class_name: 'Recipe', foreign_key: 'child_id'  

  def title
    self.recipe_part.title
  end

  def total
    self.child.total
  end

  def description
    self.recipe_part.description
  end
end
