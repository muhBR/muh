require 'rails_helper'

RSpec.describe Mutations::DeleteItem, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:item) { create(:item, user: user) }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, id: item.id)
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
      graphql_post(headers: user_headers, id: -1)
    end

    it 'returns not found message' do
      expect(json_response_error_message).to eq("Couldn't find Item with 'id'=-1")
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
