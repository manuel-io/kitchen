class Recipe < ApplicationRecord
  has_many :recipe_parts, dependent: :destroy
  has_many :connections, through: :recipe_parts, source: :part, source_type: 'connection'
  has_many :components, through: :recipe_parts, source: :part, source_type: 'component'

  has_many :sources, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true, uniqueness: true, length: { minimum: 1 }
  validates :description, presence: true

  include PgSearch
  pg_search_scope :pg_search, against: [:title, :description],
    using: {tsearch: {prefix: true}}

  def self.search(query)
    if query.present?
      pg_search(query)
    else
      where(nil)
    end
  end

  def total
    self.recipe_parts.inject(0) { |sum, poly| sum + poly.part.total }
  end

  def price_in_total
    total
  end

  def price_per_serving
    total / self.serves
  end

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
