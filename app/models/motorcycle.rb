class Motorcycle < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
  validates :amount, presence: true
  validates :duration, presence: true
end
