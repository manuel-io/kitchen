class Recipe < ApplicationRecord
  has_many :recipe_parts, dependent: :destroy
  has_many :connections, through: :recipe_parts, source: :part, source_type: 'connection'
  has_many :components, through: :recipe_parts, source: :part, source_type: 'component'

# has_many :vegetables, through: :recipe_parts, source: :part, source_type: 'vegetable'
# has_many :ingredients, through: :recipe_parts, source: :part, source_type: 'ingredient'
# has_many :seasonings, through: :recipe_parts, source: :part, source_type: 'seasoning'

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

  def self.parts
    self.reflections.values.select {|b| b if b.source_reflection.name == :part}
  end
end
