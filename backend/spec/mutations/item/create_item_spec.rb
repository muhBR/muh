require 'rails_helper'

RSpec.describe Mutations::Item::CreateItem, type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:user_headers) { header_for_user(user) }
  let(:name) { 'item name' }
  let(:item_type) { Item::TYPES[0] }
  let(:description) { 'item description' }
  let(:sale_price) { 10.0 }
  let(:purchase_price) { 5.0 }
  let(:category_id) { category.id }

  let(:params) do
    {
      name: name,
      item_type: item_type,
      description: description,
      sale_price: sale_price,
      purchase_price: purchase_price,
      category_id: category_id
    }
  end

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, params: params)
    end

    it 'returns item data' do
      data = json_response('createItem')

      expect(data).to include(
        'id' => be_present,
        'userId' => user.id.to_s,
        'name' => name,
        'itemType' => item_type,
        'description' => description,
        'salePrice' => sale_price,
        'purchasePrice' => purchase_price
      )
    end
  end

  describe 'when data is not valid' do
    let(:invalid_params) do
      {
        name: name,
        item_type: 'invalid type',
        description: description,
        sale_price: sale_price,
        purchase_price: purchase_price,
        category_id: category_id
      }
    end

    before(:each) do
      graphql_post(headers: user_headers, params: invalid_params)
    end

    it 'returns propper error message' do
      expect(json_response_error_message).to eq('Validation failed: Item type is not included in the list')
    end
  end

  def query(params)
    <<~GQL
      mutation {
        createItem(
          name: "#{params[:name]}"
          itemType: "#{params[:item_type]}"
          description: "#{params[:description]}"
          salePrice: #{params[:sale_price]}
          purchasePrice: #{params[:purchase_price]}
          categoryId: "#{params[:category_id]}"
        ) {
          id
          userId
          name
          itemType
          description
          salePrice
          purchasePrice
        }
      }
    GQL
  end
end
