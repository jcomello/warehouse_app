FactoryGirl.define do
  factory :warehouse do
    street 'Rua Vicente de carvalho'
    sequence(:number) { |n| "Forncedor #{n}" }
  end
end
