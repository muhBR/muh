require 'rails_helper'

RSpec.describe Queries::Category::FetchCategories, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:category) { create(:category, user: user) }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(id: category.id, headers: user_headers)
    end

    it 'returns category data' do
      data = json_response('fetchCategory')
      expect(data).to include(
        'id' => category.id.to_s,
        'name' => category.name,
        'userId' => user.id.to_s
      )
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'when category does not exist' do
    before(:each) do
      graphql_post(id: -1, headers: user_headers)
    end

    it 'returns not found message' do
      expect(json_response_error_message).to eq("Couldn't find Category")
    end

    it { expect(response).to have_http_status(:not_found) }
  end

  describe 'when category does not belongs to user' do
    let!(:user2) { create(:user) }
    let!(:user_headers2) { header_for_user(user2) }

    before(:each) do
      graphql_post(id: category.id, headers: user_headers2)
    end

    it 'returns not found message' do
      expect(json_response_error_message).to eq("Couldn't find Category")
    end

    it { expect(response).to have_http_status(:not_found) }
  end

  def query(id:)
    <<~GQL
      {
        fetchCategory(id:"#{id}")
        {
          id
          name
          userId
        }
      }
    GQL
  end
end
