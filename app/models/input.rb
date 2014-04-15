class Input < ActiveRecord::Base


  belongs_to :employee
  belongs_to :warehouse
  belongs_to :product
end
