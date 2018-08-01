FactoryBot.define do
  factory :pension_summary do
    trait :generated do
      generated_at { Time.current }
    end
  end
end
