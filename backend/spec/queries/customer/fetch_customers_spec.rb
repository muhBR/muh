require 'rails_helper'

RSpec.describe Queries::Customer::FetchCustomers, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:customer) { create_list(:customer, 1, user: user)[0] }
  let!(:customer2) { create_list(:customer, 1)[0] }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, params: {})
    end

    subject { json_response('fetchCustomers') }

    it 'returns customers quantity by token user' do
      expect(subject.length).to eq(1)
    end

    it 'returns customers data' do
      expect(subject[0]).to include(
        'id' => customer.id.to_s,
        'name' => customer.name,
        'phone' => customer.phone.to_s,
        'email' => customer.email
      )
    end
  end

  def query
    <<~GQL
      {
        fetchCustomers
        {
          id
          name
          email
          phone
        }
      }
    GQL
  end
end
