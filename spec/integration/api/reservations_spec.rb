require 'swagger_helper'

RSpec.describe 'Api::Reservations', type: :request do
  path '/api/users/{user_id}/reservations' do
    parameter name: :user_id, in: :path, type: :integer

    get('list reservations') do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :integer },
                   motorcycle_id: { type: :integer },
                   date: { type: :date },
                   city: { type: :string },
                   status: { type: :string }
                 }
               }
        let(:user) { create(:user) }
        run_test!
      end

      response(404, 'not found') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }
        let(:user_id) { 9999 }
        run_test!
      end
    end

    post('create reservation') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :reservation_params, in: :body, schema: {
        type: :object,
        properties: {
          motorcycle_id: { type: :integer },
          date: { type: :date },
          city: { type: :string },
          status: { type: :string }
        },
        required: %w[motorcycle_id date city]
      }

      response(201, 'created') do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 user_id: { type: :integer },
                 motorcycle_id: { type: :integer },
                 date: { type: :date },
                 city: { type: :string },
                 status: { type: :string }
               }
        let(:user) { create(:user) }
        let(:reservation_params) { attributes_for(:reservation, user_id: user.id) }
        run_test!
      end

      response(422, 'unprocessable entity') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }
        let(:user) { create(:user) }
        let(:reservation_params) { { motorcycle_id: nil, date: Date.today, city: 'City' } }
        run_test!
      end

      response(422, 'unprocessable entity due to duplicate reservation') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }
        let(:user) { create(:user) }
        let!(:existing_reservation) { create(:reservation, user:) }
        let(:reservation_params) do
          attributes_for(:reservation, user_id: user.id, motorcycle_id: existing_reservation.motorcycle_id,
                                       date: existing_reservation.date)
        end
        run_test!
      end
    end
  end

  path '/api/users/{user_id}/reservations/{reservation_id}' do
    parameter name: :user_id, in: :path, type: :integer
    parameter name: :reservation_id, in: :path, type: :integer

    delete('delete reservation') do
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 message: { type: :string }
               }
        let(:user) { create(:user) }
        let(:reservation) { create(:reservation, user:) }
        let(:user_id) { user.id }
        let(:id) { reservation.id }
        run_test!
      end

      response(404, 'not found') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }
        let(:user_id) { 9999 }
        let(:id) { 9999 }
        run_test!
      end
    end
  end
end
