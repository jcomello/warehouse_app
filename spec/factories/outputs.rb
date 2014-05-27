# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :output do
    quantity 2
    product
    employee
    warehouse

    after(:create) do |output, evaluator|
      output.product = FactoryGirl.create(:product)
      output.warehouse = FactoryGirl.create(:warehouse)
      output.save
    end
  end
end
