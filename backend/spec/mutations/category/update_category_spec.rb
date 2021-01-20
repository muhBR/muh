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

    it 'returns invalid input message' do
      expect(json_response_error_message).to eq("Validation failed: Name can't be blank")
    end
  end

  describe 'when category is not found' do
    before(:each) do
      graphql_post(headers: user_headers, name: valid_name, id: -1)
    end

    it 'returns invalid input message' do
      expect(json_response_error_message).to eq("Couldn't find Category with 'id'=-1")
    end
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
