class Recipe < ApplicationRecord
  has_many :components, dependent: :destroy
  has_many :ingredients, through: :components
  has_many :sources, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
end
