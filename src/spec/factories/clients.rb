FactoryBot.define do
  factory :client do
    sequence(:name) { |n| "クライアント#{n}" }

    trait(:with_slots) do
      after(:create) do |client, evaluator|
        create_list(:consultation_appointment_slot, 2, client: client)
      end
    end
  end
end
