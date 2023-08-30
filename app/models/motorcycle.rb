class Motorcycle < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :image, :amount, :duration, presence: true
end
