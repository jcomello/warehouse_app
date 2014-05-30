class Product < ActiveRecord::Base
  belongs_to :provider
  has_many :outputs
  has_many :inputs
  has_many :stocks

  validates :name, :provider, presence: true

  def total_count
    stocks.sum(:quantity)
  end
end
