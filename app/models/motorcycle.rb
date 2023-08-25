class Motorcycle < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :image, :amount, :duration, presence: true
end
