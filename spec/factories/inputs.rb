# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :input do
    quantity 5
    product
    employee
    warehouse

    after(:create) do |input, evaluator|
      input.product = FactoryGirl.create(:product)
      input.warehouse = FactoryGirl.create(:warehouse)
      input.save
    end
  end
end
