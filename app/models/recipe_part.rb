class RecipePart < ApplicationRecord
  attr_accessor :child_id, :scale

  belongs_to :recipe
  belongs_to :part, polymorphic: true, dependent: :destroy

  validates :recipe, presence: true
  validates :part, presence: true
  validates :title, presence: true
end
