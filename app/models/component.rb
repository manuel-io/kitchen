class Component < ApplicationRecord
  belongs_to :recipe
  has_many :ingredients, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
end
