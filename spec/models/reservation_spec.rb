require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:city) }

    it 'validates uniqueness of motorcycle_id within the scope of date' do
      existing_reservation = create(:reservation)
      subject = build(:reservation, motorcycle: existing_reservation.motorcycle, date: existing_reservation.date)
      expect(subject).not_to be_valid
      expect(subject.errors[:motorcycle_id]).to include('Motorcycle is already reserved for this date')
    end
  end

  describe 'uniqueness validation' do
    it 'validates uniqueness of motorcycle_id and date' do
      existing_reservation = create(:reservation)
      subject = build(:reservation, motorcycle: existing_reservation.motorcycle, date: existing_reservation.date)

      expect(subject).to_not be_valid
      expect(subject.errors[:motorcycle_id]).to include('Motorcycle is already reserved for this date')
    end
  end
end
