class Motorcycle < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :image, :amount, :duration, :description, presence: true
end
