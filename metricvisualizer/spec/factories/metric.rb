FactoryBot.define do
  factory :metric do
    name { 'test' }
    value { Faker::Number.within(range: 1..4) }
    uid { Faker::Internet.uuid }
    sequence(:created_at, aliases: [:updated_at]) { |n| (n * 10).seconds.from_now }
  end
end
