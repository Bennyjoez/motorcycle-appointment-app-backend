require 'rails_helper'

RSpec.describe Motorcycle, type: :model do
  let(:motorcycle) { create(:motorcycle) }

  after do
    Motorcycle.destroy_all
  end

  it 'creates with valid attributes' do
    expect(motorcycle).to be_valid
  end

  it 'invalidates with a duplicate name' do
    create(:motorcycle, name: 'Cruiser')
    new_motorcycle = build(:motorcycle, name: 'Cruiser')
    expect(new_motorcycle).to_not be_valid
  end

  it 'invalidates without a name' do
    motorcycle2 = build(:motorcycle, name: nil)
    expect(motorcycle2).to_not be_valid
  end

  it 'invalidates without an image' do
    motorcycle2 = build(:motorcycle, image: nil)
    expect(motorcycle2).to_not be_valid
  end

  it 'invalidates without an amount' do
    motorcycle2 = build(:motorcycle, amount: nil)
    expect(motorcycle2).to_not be_valid
  end

  it 'invalidates without an duration' do
    motorcycle2 = build(:motorcycle, duration: nil)
    expect(motorcycle2).to_not be_valid
  end
end
