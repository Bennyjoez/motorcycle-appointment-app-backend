FactoryBot.define do
  factory :reservation do
    association :user
    association :motorcycle
    date { Date.today + rand(1..30).days }
    city { 'Sample City' }
    status { 'pending' }
  end
end
