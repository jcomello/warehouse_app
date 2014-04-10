# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :employee do
    sequence(:name)  { |n| "Funcionário #{n}" }
    sequence(:email) { |n| "email_#{n}@exemplo.com" }
    password '123123123'
    password_confirmation '123123123'
  end
end
