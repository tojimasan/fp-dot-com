FactoryBot.define do
  factory :financial_planner do
    sequence(:name) { |n| "FP#{n}" }
  end
end
