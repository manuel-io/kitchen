class Recipe < ApplicationRecord
  has_many :components, dependent: :destroy
  has_many :ingredients, through: :components
  has_many :sources, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, uniqueness: true, length: { minimum: 1 }
  validates :description, presence: true

  def tags_by_name(names)
   self
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end
  
  def all_tags
    self.tags.map(&:name).join(", ")
  end
end
