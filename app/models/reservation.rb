class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :motorcycle
  validates :motorcycle_id, :user_id, :date, :city, presence: true
end
