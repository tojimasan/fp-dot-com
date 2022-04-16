FactoryBot.define do
  factory :consultation_appointment_slot do
    client { nil }
    financial_planner { nil }
    start_at { "2022-04-17 06:42:01" }
    end_at { "2022-04-17 06:42:01" }
    status { 1 }
  end
end
