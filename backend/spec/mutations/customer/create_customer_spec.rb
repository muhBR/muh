require 'rails_helper'

RSpec.describe Mutations::Customer::CreateCustomer, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let(:name) { 'customer name' }
  let(:phone) { '912341234' }
  let(:email) { 'example@email.com' }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, params: { name: name, phone: phone, email: email })
    end

    it 'returns customer data' do
      data = json_response('createCustomer')

      expect(data).to include(
        'id' => be_present,
        'name' => name,
        'phone' => phone,
        'email' => email
      )
    end
  end

  describe 'when data is not valid' do
    let(:invalid_name) { '' }

    before(:each) do
      graphql_post(headers: user_headers, params: { name: invalid_name, phone: phone, email: email })
    end

    it 'returns customer data' do
      expect(json_response_error_message).to eq("Validation failed: Name can't be blank")
    end
  end

  def query(name:, phone:, email:)
    <<~GQL
      mutation {
        createCustomer(
          name: "#{name}",
          phone: "#{phone}",
          email: "#{email}"
        ) {
          id
          name
          phone
          email
        }
      }
    GQL
  end
end
