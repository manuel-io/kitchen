class Component < ApplicationRecord
  belongs_to :recipe
  has_many :ingredients, dependent: :destroy

  validates :recipe, presence: true
  validates :title, presence: true, length: { minimum: 1 }
end
