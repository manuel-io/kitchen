class Source < ApplicationRecord
  belongs_to :recipe

  validates :recipe, presence: true
  validates :title, presence: true, uniqueness: { scope: :recipe_id }
  validates :url, presence: true, uniqueness: { scope: :recipe_id }
end
