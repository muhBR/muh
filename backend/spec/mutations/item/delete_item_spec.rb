require 'rails_helper'

RSpec.describe Mutations::Item::DeleteItem, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:item) { create(:item, user: user) }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, params: { id: item.id })
    end

    it 'returns item data' do
      data = json_response('deleteItem')

      expect(data).to include(
        'id' => item.id.to_s,
        'name' => item.name,
        'userId' => user.id.to_s
      )
    end

    it 'deletes item' do
      expect(Item.count).to eq(0)
    end
  end

  describe 'when data is not valid' do
    before(:each) do
      graphql_post(headers: user_headers, params: { id: -1 })
    end

    it 'returns not found message' do
      expect(json_response_error_message).to eq("Couldn't find Item")
    end
  end

  describe 'item does not belongs to user' do
    let!(:user2) { create(:user) }
    let!(:user_headers2) { header_for_user(user2) }

    before(:each) do
      graphql_post(headers: user_headers2, params: { id: item.id })
    end

    it 'returns not found message' do
      expect(json_response_error_message).to eq("Couldn't find Item")
    end
  end

  def query(id:)
    <<~GQL
      mutation {
        deleteItem(
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
