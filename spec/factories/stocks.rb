# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stock do
    quantity 1
    product nil
    warehouse nil
  end
end
