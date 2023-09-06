class User < ApplicationRecord
  has_many :reservations
  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
