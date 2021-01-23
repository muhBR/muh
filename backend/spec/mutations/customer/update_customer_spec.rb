require 'rails_helper'

RSpec.describe Mutations::Customer::UpdateCustomer, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:customer) { create(:customer, user: user) }
  let(:name) { 'customer name' }
  let(:phone) { '912341234' }
  let(:email) { 'example@email.com' }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, params: { name: name, phone: phone, email: email, id: customer.id })
    end

    it 'returns customer data' do
      data = json_response('updateCustomer')

      expect(data).to include(
        'id' => customer.id.to_s,
        'name' => name,
        'phone' => phone.to_s,
        'email' => email
      )
    end
  end

  describe 'when customer name is not valid' do
    before(:each) do
      graphql_post(headers: user_headers, params: { name: '', phone: phone, email: email, id: customer.id })
    end

    it { expect(json_response_error_message).to eq("Validation failed: Name can't be blank") }

    it { expect(response).to have_http_status(:unprocessable_entity) }
  end

  describe 'when customer is not found' do
    before(:each) do
      graphql_post(headers: user_headers, params: {  name: '', phone: phone, email: email, id: -1 })
    end

    it { expect(json_response_error_message).to eq("Couldn't find Customer") }
  end

  describe 'when customer belongs to other user' do
    let!(:user2) { create(:user) }
    let!(:user_headers2) { header_for_user(user2) }

    before(:each) do
      graphql_post(headers: user_headers2, params: { name: name, phone: phone, email: email, id: customer.id })
    end

    it { expect(json_response_error_message).to eq("Couldn't find Customer") }
  end

  def query(name:, phone:, email:, id:)
    <<~GQL
      mutation {
        updateCustomer(
          id: "#{id}",
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
