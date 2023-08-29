require 'swagger_helper'

RSpec.describe 'Api::Motorcycles', type: :request do
  path '/api/motorcycles' do
    get('list motorcycles') do
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              image: { type: :string },
              amount: { type: :integer },
              duration: { type: :integer }
            }
          }
        run_test!
      end
    end

    post('create motorcycle') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :motorcycle_params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          image: { type: :string },
          amount: { type: :integer },
          duration: { type: :integer }
        },
        required: ['name', 'amount']
      }

      response(201, 'created') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            image: { type: :string },
            amount: { type: :integer },
            duration: { type: :integer }
          }
        let(:motorcycle_params) { { name: 'Bike', amount: 100 } }
        run_test!
      end

      response(422, 'unprocessable entity') do
        schema type: :object,
          properties: {
            errors: { type: :array, items: { type: :string } }
          }
        let(:motorcycle_params) { { name: nil, amount: 100 } }
        run_test!
      end
    end
  end

  path '/api/motorcycles/{motorcycle_id}' do
    parameter name: :motorcycle_id, in: :path, type: :integer

    get('get motorcycle') do
      produces 'application/json'
      response(200, 'successful') do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            image: { type: :string },
            amount: { type: :integer },
            duration: { type: :integer }
          }
        run_test!
      end

      response(404, 'not found') do
        schema type: :object,
          properties: {
            error: { type: :string }
          }
        let(:id) { 9999 }
        run_test!
      end
    end

    delete('delete motorcycle') do
      produces 'application/json'
      response(200, 'successful') do
        schema type: :object,
          properties: {
            message: { type: :string }
          }
        let(:motorcycle) { create(:motorcycle) }
        let(:id) { motorcycle.id }
        run_test!
      end

      response(422, 'unprocessable entity') do
        schema type: :object,
          properties: {
            error: { type: :string }
          }
        let(:id) { 9999 }
        run_test!
      end
    end
  end
end
