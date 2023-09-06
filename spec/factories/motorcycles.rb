FactoryBot.define do
  factory :motorcycle do
    name { 'Bike' }
    image { 'url' }
    amount { 1.5 }
    duration { 1 }
    description { 'This is a motorcycle description' }
  end
end
