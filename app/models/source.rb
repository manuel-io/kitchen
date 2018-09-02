class Source < ApplicationRecord
  belongs_to :recipe

  validates :recipe, presence: true
  validates :title, presence: true, uniqueness: { scope: :recipe }
  validates :url, presence: true, uniqueness: { scope: :recipe }


  def self.search(query)
    if query.present?
      where('title ilike :q', q: '%#{query}%')
    else
      scoped
    end
  end
end
