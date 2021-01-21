require 'rails_helper'

RSpec.describe Mutations::Category::DeleteCategory, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:category) { create(:category, user: user) }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, id: category.id)
    end

    it 'returns category data' do
      data = json_response('deleteCategory')

      expect(data).to include(
        'id' => category.id.to_s,
        'name' => category.name,
        'userId' => user.id.to_s
      )
    end

    it { expect(Category.count).to eq(0) }

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'when data is not valid' do
    before(:each) do
      graphql_post(headers: user_headers, id: -1)
    end

    it { expect(json_response_error_message).to eq("Couldn't find Category") }

    it { expect(response).to have_http_status(:not_found) }
  end

  describe 'when category does not belongs to user' do
    let!(:user2) { create(:user) }
    let!(:user_headers2) { header_for_user(user2) }

    before(:each) do
      graphql_post(headers: user_headers2, id: category.id)
    end

    it { expect(json_response_error_message).to eq("Couldn't find Category") }

    it { expect(response).to have_http_status(:not_found) }
  end

  def query(id:)
    <<~GQL
      mutation {
        deleteCategory(
          id: "#{id}"
        ){
          id
          name
          userId
        }
      }
    GQL
  end
end
