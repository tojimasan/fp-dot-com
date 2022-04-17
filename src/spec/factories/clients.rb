FactoryBot.define do
  factory :client do
    sequence(:id) { |n| n } # シーケンスを使う
    sequence(:name) { |n| "クライアント#{n}" }
    created_at { Time.current }
    updated_at { Time.current }

    trait :kazutoクライアント do
      name { 'kazutoクライアント' }
    end

    factory :kazutoクライアント, traits: [:kazutoクライアント]
  end
end
