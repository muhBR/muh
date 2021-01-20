require 'rails_helper'

RSpec.describe Mutations::UpdateItem, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:item) { create(:item, user: user) }
  let!(:category) { create(:category) }

  let(:name) { 'item name' }
  let(:item_type) { Item::TYPES[0] }
  let(:description) { 'item description' }
  let(:sale_price) { 10.0 }
  let(:purchase_price) { 5.0 }
  let(:category_id) { category.id }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, id: item.id,
                   name: name, item_type: item_type, description: description,
                   sale_price: sale_price, purchase_price: purchase_price,
                   category_id: category_id)
    end

    it 'returns item data' do
      item_data = json_response('updateItem')
      category_data = item_data['category']

      expect(item_data).to include(
        'id' => be_present,
        'userId' => user.id.to_s,
        'name' => name,
        'itemType' => item_type,
        'description' => description,
        'salePrice' => sale_price,
        'purchasePrice' => purchase_price
      )

      expect(category_data).to include(
        'id' => category.id.to_s,
        'name' => category.name
      )
    end
  end

  describe 'when item name is not valid' do
    before(:each) do
      graphql_post(headers: user_headers, id: item.id,
                   name: '', item_type: item_type, description: description,
                   sale_price: sale_price, purchase_price: purchase_price,
                   category_id: category_id)
    end

    it 'returns invalid input message' do
      expect(json_response_error_message).to eq("Validation failed: Name can't be blank")
    end
  end

  describe 'when item is not found' do
    before(:each) do
      graphql_post(headers: user_headers, id: -1,
                   name: '', item_type: item_type, description: description,
                   sale_price: sale_price, purchase_price: purchase_price,
                   category_id: category_id)
    end

    it 'returns invalid input message' do
      expect(json_response_error_message).to eq("Couldn't find Item with 'id'=-1")
    end
  end

  def query(params)
    <<~GQL
      mutation {
        updateItem(
          id: "#{params[:id]}",
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
          category {
            id
            name
          }
        }
      }
    GQL
  end
end
