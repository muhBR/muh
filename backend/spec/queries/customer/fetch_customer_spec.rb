require 'rails_helper'

RSpec.describe Queries::Customer::FetchCustomers, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:customer) { create(:customer, user: user) }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(params: { id: customer.id }, headers: user_headers)
    end

    it 'returns customer data' do
      data = json_response('fetchCustomer')
      expect(data).to include(
        'id' => customer.id.to_s,
        'name' => customer.name,
        'phone' => customer.phone.to_s,
        'email' => customer.email
      )
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'when customer does not exist' do
    before(:each) do
      graphql_post(params: { id: -1 }, headers: user_headers)
    end

    it 'returns not found message' do
      expect(json_response_error_message).to eq("Couldn't find Customer")
    end

    it { expect(response).to have_http_status(:not_found) }
  end

  describe 'when customer does not belongs to user' do
    let!(:user2) { create(:user) }
    let!(:user_headers2) { header_for_user(user2) }

    before(:each) do
      graphql_post(params: { id: customer.id }, headers: user_headers2)
    end

    it 'returns not found message' do
      expect(json_response_error_message).to eq("Couldn't find Customer")
    end

    it { expect(response).to have_http_status(:not_found) }
  end

  def query(id:)
    <<~GQL
      {
        fetchCustomer(id:"#{id}")
        {
          id
          name
          phone
          email
        }
      }
    GQL
  end
end
