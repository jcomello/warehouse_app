class Stock < ActiveRecord::Base
  belongs_to :product
  belongs_to :warehouse

  validates :quantity, numericality: { greater_than: 0 }
end
