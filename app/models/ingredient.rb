class Ingredient < ApplicationRecord
  attr_accessor :uid

  belongs_to :component
  belongs_to :adding, polymorphic: true

  validates :adding_id, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :unit, presence: true
  validates_inclusion_of :unit, in: %w|g ml x TL EL|
  validates :title, presence: true

  def total
    amount = case self.unit
      when 'TL' then self.amount.to_f * 5
      when 'EL' then self.amount.to_f * 15
      else self.amount.to_f
    end
    amount * (self.adding.price.to_f / self.adding.amount.to_f)
  end

  def amount
    super.to_s.sub(/\.0+/, '')
  end
end
