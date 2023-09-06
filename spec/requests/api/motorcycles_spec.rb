require 'rails_helper'

RSpec.describe 'Api::Motorcycles', type: :request do
  describe 'GET #index' do
    it 'returns a list of motorcycles' do
      create(:motorcycle, name: 'one')
      create(:motorcycle, name: 'two')
      create(:motorcycle, name: 'three')
      get '/api/motorcycles'
      expect(response).to have_http_status(:ok)
      expect(response_body.count).to eq(3)
    end
  end

  describe 'GET #show' do
    it 'returns a specific motorcycle' do
      motorcycle = create(:motorcycle)
      get "/api/motorcycles/#{motorcycle.id}"
      expect(response).to have_http_status(:ok)
      expect(response_body['name']).to eq(motorcycle.name)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new motorcycle' do
        motorcycle_params = attributes_for(:motorcycle)
        post '/api/motorcycles', params: { motorcycle: motorcycle_params }
        expect(response).to have_http_status(:created)
        expect(Motorcycle.count).to eq(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a motorcycle' do
        post '/api/motorcycles', params: { motorcycle: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Motorcycle.count).to eq(0)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a motorcycle' do
      motorcycle = create(:motorcycle)
      delete "/api/motorcycles/#{motorcycle.id}"
      expect(response).to have_http_status(:ok)
      expect(response_body['message']).to eq('Motorcycle was deleted successfully')
      expect(Motorcycle.count).to eq(0)
    end
  end

  # Helper method to parse JSON response body
  def response_body
    JSON.parse(response.body)
  end
end
