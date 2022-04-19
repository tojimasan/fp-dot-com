FactoryBot.define do
  factory :client do
    sequence(:name) { |n| "クライアント#{n}" }
  end
end
