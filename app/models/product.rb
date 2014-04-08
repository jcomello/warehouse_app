class Product < ActiveRecord::Base
  belongs_to :provider
  has_many :outputs
  has_many :inputs

  validates :name, :provider, presence: true
end
