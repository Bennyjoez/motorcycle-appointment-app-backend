require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/api/register' do
    post('register user') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string }
        },
        required: ['username']
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 username: { type: :string }
               }
        let(:user_params) { { username: 'john' } }
        run_test!
      end
    end
  end

  path '/api/login' do
    post('login user') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user_params, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string }
        },
        required: ['username']
      }

      response(200, 'successful') do
        schema type: :object,
               properties: {
                 username: { type: :string }
               }
        let(:user_params) { { username: 'john' } }
        run_test!
      end
    end
  end
end
