class Warehouse < ActiveRecord::Base
  has_many :outputs
  has_many :inputs
end
