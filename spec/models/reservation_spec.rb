require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'validations' do
    # ...
  end

  describe 'uniqueness validation' do
    it 'validates uniqueness of motorcycle_id and date' do
      existing_reservation = create(:reservation)
      puts "Existing motorcycle: #{existing_reservation.motorcycle.inspect}"
      puts "Existing date: #{existing_reservation.date.inspect}"

      subject = build(:reservation, motorcycle: existing_reservation.motorcycle, date: existing_reservation.date)
      puts "Subject attributes: #{subject.attributes}"
      
      # Save the subject and check if it's invalid
      subject.save
      puts "Subject errors: #{subject.errors.full_messages}"
      
      expect(subject.errors[:motorcycle_id]).to include('has already been taken')
    end
  end
end