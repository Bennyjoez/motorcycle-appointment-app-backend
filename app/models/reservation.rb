class Reservation < ApplicationRecord
  validates :vehicle_app, :model_name, :user_id, :date, :city, :status, presence: true
end
