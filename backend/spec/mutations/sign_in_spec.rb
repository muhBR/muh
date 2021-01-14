require 'rails_helper'

RSpec.describe Mutations::SignIn, type: :request do
  let(:correct_password) { 'secret1' }
  let!(:user) { create(:user, password: correct_password) }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(email: user.email, password: correct_password)
    end

    it 'returns proper data' do
      data = json_response('signIn')

      expect(data).to include(
        'id' => be_present,
        'email' => user.email,
        'token' => be_present
      )
    end
  end

  describe 'when data is not valid' do
    describe 'When email is invalid' do
      before(:each) do
        graphql_post(email: 'invalid_email@gmail.com', password: correct_password)
      end

      it 'returns error message' do
        expect(json_response_error_message).to eq('Unauthorized :(')
      end
    end

    describe 'When password is invalid' do
      before(:each) do
        graphql_post(email: user.email, password: 'wrong_password')
      end

      it 'returns error message' do
        expect(json_response_error_message).to eq('Unauthorized :(')
      end
    end
  end

  def query(email:, password:)
    <<~GQL
      mutation {
        signIn(
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
