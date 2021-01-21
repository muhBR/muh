require 'rails_helper'

RSpec.describe Mutations::Category::UpdateCategory, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:category) { create(:category, user: user) }
  let(:valid_name) { 'updated category name' }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, name: valid_name, id: category.id)
    end

    it 'returns category data' do
      data = json_response('updateCategory')

      expect(data).to include(
        'id' => be_present,
        'name' => valid_name,
        'userId' => user.id.to_s
      )
    end
  end

  describe 'when category name is not valid' do
    before(:each) do
      graphql_post(headers: user_headers, name: '', id: category.id)
    end

    it { expect(json_response_error_message).to eq("Validation failed: Name can't be blank") }

    it { expect(response).to have_http_status(:unprocessable_entity) }
  end

  describe 'when category is not found' do
    before(:each) do
      graphql_post(headers: user_headers, name: valid_name, id: -1)
    end

    it { expect(json_response_error_message).to eq("Couldn't find Category") }
  end

  describe 'when category belongs to other user' do
    let!(:user2) { create(:user) }
    let!(:user_headers2) { header_for_user(user2) }

    before(:each) do
      graphql_post(headers: user_headers2, name: valid_name, id: category.id)
    end

    it { expect(json_response_error_message).to eq("Couldn't find Category") }
  end

  def query(name:, id:)
    <<~GQL
      mutation {
        updateCategory(
          id: "#{id}",
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
