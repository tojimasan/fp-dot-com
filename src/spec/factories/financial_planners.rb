FactoryBot.define do
  factory :financial_planner do
    sequence(:name) { |n| "FP#{n}" }

    trait(:with_slots) do
      after(:create) do |financial_planner, evaluator|
        create_list(:consultation_appointment_slot, 2, financial_planner: financial_planner)
      end
    end
  end
end
