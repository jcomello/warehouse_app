class Product < ActiveRecord::Base
  belongs_to :provider
  has_many :outputs
  has_many :inputs
end
