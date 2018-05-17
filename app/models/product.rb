class Product < ApplicationRecord
  has_many :ingredients, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: [ :manufacturer, :shop, :amount, :liquid ] }
  validates :manufacturer, presence: true
  validates :shop, presence: true
  validates :amount, presence: true,  numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true,  numericality: { greater_than: 0 }
  validates :liquid, inclusion: { in: [ true, false ] }

  validate :check_code_length
  
  def check_code_length
    unless  [8, 12, 13].include? code.length
      errors.add :code, 'EAN-8, EAN-13, UPC-A'
    end
  end

   %w[energy fat_total fat_saturated carbohydrate sugar fiber protein].each do |name|
     define_method name.to_sym do
       method(name).super_method.call.to_s.sub(/\.0+/, '')
     end
   end
end
