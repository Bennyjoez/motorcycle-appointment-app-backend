require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  before do
    user.save
  end

  after do
    User.destroy_all
  end

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'has a unique username' do
    user2 = build(:user)
    expect(user2).to_not be_valid
  end

  it 'username cannot be blank' do
    user = build(:user, username: nil)
    expect(user).to_not be_valid
  end
end
