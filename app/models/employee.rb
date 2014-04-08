class Employee < ActiveRecord::Base
  has_many :outputs
  has_many :inputs
end
