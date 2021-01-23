require 'rails_helper'

RSpec.describe Mutations::User::CreateUser, type: :request do
  describe 'when data is valid' do
    let(:valid_email) { 'email@gmail.com' }
    let(:valid_password) { 'secret' }

    before(:each) do
      graphql_post(params: { email: valid_email, password: valid_password })
    end

    it 'returns proper data' do
      data = json_response('createUser')

      expect(data).to include(
        'id' => be_present,
        'email' => valid_email,
        'token' => be_present
      )
    end
  end

  describe 'when data is not valid' do
    let(:invalid_email) { 'invalid_email.com' }
    let(:valid_password) { 'secret' }

    before(:each) do
      graphql_post(params: { email: invalid_email, password: valid_password })
    end

    it 'returns proper error message' do
      expect(json_response_error_message).to eq('Validation failed: Email is invalid')
    end
  end

  def query(email:, password:)
    <<~GQL
      mutation {
        createUser(
          email: "#{email}"
          password: "#{password}"
        ) {
          id
          email
          token
        }
      }
    GQL
  end
end
