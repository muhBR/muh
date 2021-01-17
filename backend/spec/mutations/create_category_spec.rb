require 'rails_helper'

RSpec.describe Mutations::CreateCategory, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }

  describe 'when data is valid' do
    let(:valid_name) { 'category name' }

    before(:each) do
      graphql_post(headers: user_headers, name: valid_name)
    end

    it 'returns category data' do
      data = json_response('createCategory')

      expect(data).to include(
        'id' => be_present,
        'name' => valid_name,
        'userId' => user.id.to_s
      )
    end
  end

  describe 'when data is not valid' do
    let(:invalid_name) { '' }

    before(:each) do
      graphql_post(headers: user_headers, name: invalid_name)
    end

    it 'returns category data' do
      expect(json_response_error_message).to eq("Validation failed: Name can't be blank")
    end
  end

  describe 'when headers are not valid' do
    let(:valid_name) { 'category name' }

    before(:each) do
      graphql_post(headers: {}, name: valid_name)
    end

    it { expect(response).to have_http_status(:unauthorized) }
  end

  def query(name:)
    <<~GQL
      mutation {
        createCategory(
          name: "#{name}"
        ) {
          id
          name
          userId
        }
      }
    GQL
  end
end
