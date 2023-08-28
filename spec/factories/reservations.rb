# FactoryBot.define do
#   factory :reservation do
#     user { nil }
#     motorcycle { nil }
#   end
# end
# spec/factories/reservations.rb
# spec/factories/reservations.rb
FactoryBot.define do
  factory :reservation do
    association :user
    association :motorcycle
    date { Date.today + rand(1..30).days } # Generate a random future date
    city { 'Sample City' }
    status { 'pending' }
  end
end




