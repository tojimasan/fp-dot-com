FactoryBot.define do
  factory :consultation_appointment_slot do
    client
    financial_planner
    start_at { "2022-04-18 10:00:00" }
    end_at { "2022-04-18 10:30:00" }
    status { [1, 2].sample }
  end
end
