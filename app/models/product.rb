class Product < ApplicationRecord
  validates :title, presence: true, length: { minimum: 4 }, uniqueness: true
  validates :amount, presence: true,  numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true,  numericality: { greater_than: 0 }
  validates :liquid, inclusion: { in: [ true, false ] }

  def code
    return code if code = self.codes.first
    self.title
  end

  def price_s
    "%.2f" % self.price
  end

   %w[energy fat_total fat_saturated carbohydrate sugar fiber protein].each do |name|
     define_method name.to_sym do
       method(name).super_method.call.to_s.sub(/\.0+/, '')
     end
   end
end
