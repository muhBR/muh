require 'rails_helper'

RSpec.describe Mutations::Customer::DeleteCustomer, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:customer) { create(:customer, user: user) }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, params: { id: customer.id })
    end

    it 'returns customer data' do
      data = json_response('deleteCustomer')

      expect(data).to include(
        'id' => customer.id.to_s,
        'name' => customer.name
      )
    end

    it { expect(Customer.count).to eq(0) }

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'when data is not valid' do
    before(:each) do
      graphql_post(headers: user_headers, params: { id: -1 })
    end

    it { expect(json_response_error_message).to eq("Couldn't find Customer") }

    it { expect(response).to have_http_status(:not_found) }
  end

  describe 'when customer does not belongs to user' do
    let!(:user2) { create(:user) }
    let!(:user_headers2) { header_for_user(user2) }

    before(:each) do
      graphql_post(headers: user_headers2, params: { id: customer.id })
    end

    it { expect(json_response_error_message).to eq("Couldn't find Customer") }

    it { expect(response).to have_http_status(:not_found) }
  end

  def query(id:)
    <<~GQL
      mutation {
        deleteCustomer(
          id: "#{id}"
        ){
          id
          name
        }
      }
    GQL
  end
end
