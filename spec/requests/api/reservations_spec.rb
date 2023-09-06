require 'rails_helper'

RSpec.describe 'Api::Reservations', type: :request do
  let(:user) { create(:user) }
  let(:motorcycle) { create(:motorcycle) }

  describe 'GET #index' do
    it 'returns a list of reservations' do
      create(:reservation, user:, motorcycle:, date: '05-03-2023')
      create(:reservation, user:, motorcycle:, date: '05-04-2023')
      create(:reservation, user:, motorcycle:, date: '05-05-2023')
      get "/api/users/#{user.id}/reservations"
      expect(response).to have_http_status(:ok)
      expect(response_body.count).to eq(3)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new reservation' do
        motorcycle = create(:motorcycle)
        reservation_params = attributes_for(:reservation, motorcycle_id: motorcycle.id)
        post "/api/users/#{user.id}/reservations", params: { reservation: reservation_params }
        expect(response).to have_http_status(:created)
        expect(Reservation.count).to eq(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a reservation' do
        post "/api/users/#{user.id}/reservations", params: { reservation: { date: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(Reservation.count).to eq(0)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a reservation' do
      reservation = create(:reservation)
      delete "/api/reservations/#{reservation.id}"
      expect(response).to have_http_status(:ok)
      expect(response_body['message']).to eq('Reservation deleted successfully!')
      expect(Reservation.count).to eq(0)
    end
  end

  # Helper method to parse JSON response body
  def response_body
    JSON.parse(response.body)
  end
end
