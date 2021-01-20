require 'rails_helper'

RSpec.describe Queries::Item::FetchItems, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:item) { create(:item, user: user) }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(id: item.id, headers: user_headers)
    end

    it 'returns items data' do
      item_data = json_response('fetchItem')
      category_data = item_data['category']

      expect(item_data).to include(
        'id' => item.id.to_s,
        'userId' => user.id.to_s,
        'name' => item.name,
        'itemType' => item.item_type,
        'description' => item.description,
        'salePrice' => item.sale_price,
        'purchasePrice' => item.purchase_price
      )

      expect(category_data).to include(
        'id' => item.category.id.to_s,
        'name' => item.category.name
      )
    end
  end

  def query(id:)
    <<~GQL
      {
        fetchItem(id:"#{id}")
        {
          id
          userId
          name
          itemType
          description
          salePrice
          purchasePrice
          category {
            id
            name
          }
        }
      }
    GQL
  end
end
