FactoryGirl.define do
  factory :provider do
    sequence(:name) { |n| "Forncedor #{n}" }
  end
end
