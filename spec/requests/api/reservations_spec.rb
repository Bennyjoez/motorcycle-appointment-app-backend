require 'rails_helper'

RSpec.describe 'Api::ReservationsController', type: :request do
  let(:user) { create(:user) }
  let(:motorcycle) { create(:motorcycle) }
  let(:valid_attributes) { { user_id: user.id, motorcycle_id: motorcycle.id, date: Date.today } }

  describe 'POST /api/reservations' do
    context 'when the request is valid' do
      it 'creates a reservation' do
        post '/api/reservations', params: { reservation: valid_attributes }

        expect(response).to have_http_status(:created)
        expect(json_response).to include('id', 'user_id', 'motorcycle_id', 'date', 'city', 'status')
      end
    end

    context 'when the request is invalid' do
      it 'returns a validation error' do
        create(:reservation, valid_attributes)

        post '/api/reservations', params: { reservation: valid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['error']).to eq('Reservation for this motorcycle and date already exists')
      end
    end
  end

  describe 'GET /api/users/:user_id/reservations' do
    it 'returns a list of user reservations' do
      create(:reservation, user: user) # Assuming you have a reservation factory
        
      get "/api/users/#{user.id}/reservations"
      
      expect(response).to have_http_status(:success)
      expect(json_response.first).to include('id', 'user_id', 'motorcycle_id', 'date', 'city', 'status')
    end

    it 'returns a not found error if the user does not exist' do
      get "/api/users/#{user.id + 1}/reservations"
      
      expect(response).to have_http_status(:not_found)
      expect(json_response['error']).to eq('User not found')
    end
  end
  
  describe 'DELETE /api/reservations/:id' do
    let!(:reservation) { create(:reservation, user: user) } # Assuming you have a reservation factory
    
    it 'deletes a reservation' do
      delete "/api/reservations/#{reservation.id}"
      
      expect(response).to have_http_status(:success)
      expect(json_response['message']).to eq('Reservation deleted successfully!')
    end

    it 'returns an error if reservation deletion fails' do
      allow_any_instance_of(Reservation).to receive(:destroy).and_return(false)
      
      delete "/api/reservations/#{reservation.id}"
      
      expect(response).to have_http_status(:unprocessable_entity)
      expect(json_response['error']).to eq('Failed to delete the reservation')
    end
  end
end
