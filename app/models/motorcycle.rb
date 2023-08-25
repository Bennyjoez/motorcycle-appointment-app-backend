class Motorcycle < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :image, presence: true, uniqueness: true
  validates :amount, presence: true, uniqueness: true
  validates :duration, presence: true, uniqueness: true
end
