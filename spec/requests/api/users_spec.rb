require 'rails_helper'

RSpec.describe 'Api::Users', type: :request do
  let(:user) { create(:user) }

  after do
    User.destroy_all
  end

  describe 'POST #register' do
    context 'with valid attributes' do
      it 'creates a new user' do
        post '/api/register', params: { username: 'new_user' }
        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a user' do
        post '/api/register', params: { username: 'John' }
        expect(User.count).to eq(1)
      end
    end
  end

  describe 'GET #login' do
    context 'when user exists' do
      it "returns the user's information" do
        user = create(:user, username: 'existing_user')
        post '/api/login', params: { username: 'existing_user' }
        expect(response).to have_http_status(:ok)
        expect(response_body['username']).to eq(user.username)
      end
    end

    context 'when user does not exist' do
      it "returns a 'not found' error" do
        post '/api/login', params: { username: 'non_existent_user' }
        expect(response).to have_http_status(:not_found)
        expect(response_body['error']).to eq('User not found')
      end
    end
  end

  # Helper method to parse JSON response body
  def response_body
    JSON.parse(response.body)
  end
end
