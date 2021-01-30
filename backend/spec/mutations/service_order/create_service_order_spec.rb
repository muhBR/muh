require 'rails_helper'

RSpec.describe Mutations::ServiceOrder::CreateServiceOrder, type: :request do
  let!(:user) { create(:user) }
  let!(:customer) { create(:customer) }
  let!(:items) { create_list(:item, 2) }
  let!(:item_service_orders) do
    [
      {
        item_id: items[0].id,
        quantity: 1
      },
      {
        item_id: items[1].id,
        quantity: 2
      }
    ]
  end
  let!(:user_headers) { header_for_user(user) }

  let(:name) { 'serviceOrder name' }
  let(:status) { ServiceOrder::STATUSES[0] }
  let(:extra_information) { 'extra_information' }
  let(:accomplishment_date) { '14-01-2021' }
  let(:delivery_date) { '15-01-2021' }
  let(:discount) { 10.5 }
  let(:customer_id) { customer.id }

  let(:params) do
    {
      name: name,
      status: status,
      extra_information: extra_information,
      accomplishment_date: accomplishment_date,
      delivery_date: delivery_date,
      discount: discount,
      customer_id: customer_id,
      item_service_orders: item_service_orders
    }
  end

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, params: params)
    end

    subject { json_response('createServiceOrder') }

    it 'returns serviceOrder data' do
      expect(subject).to include(
        'id' => be_present,
        'name' => name,
        'status' => status,
        'extraInformation' => extra_information,
        'accomplishmentDate' => accomplishment_date,
        'deliveryDate' => delivery_date,
        'discount' => discount
      )
    end

    it 'returns customer data' do
      expect(subject['customer']).to include(
        'id' => customer.id.to_s,
        'name' => customer.name,
        'email' => customer.email,
        'phone' => customer.phone.to_s
      )
    end

    it 'returns items service order data' do
      expect(subject['itemServiceOrders'][0]).to include(
        'id' => be_present,
        'serviceOrderId' => be_present,
        'itemId' => item_service_orders[0][:item_id].to_s,
        'quantity' => item_service_orders[0][:quantity],
        'salePrice' => items[0].sale_price,
        'purchasePrice' => items[0].purchase_price
      )
      expect(subject['itemServiceOrders'][1]).to include(
        'id' => be_present,
        'serviceOrderId' => be_present,
        'itemId' => item_service_orders[1][:item_id].to_s,
        'quantity' => item_service_orders[1][:quantity],
        'salePrice' => items[1].sale_price,
        'purchasePrice' => items[0].purchase_price
      )
    end
  end

  describe 'when items are not found' do
    let!(:item_service_orders_not_found) do
      [
        {
          item_id: -1,
          quantity: 1
        },
        {
          item_id: -2,
          quantity: 2
        }
      ]
    end
    let(:params_with_invalid_items) do
      {
        name: name,
        status: status,
        extra_information: extra_information,
        accomplishment_date: accomplishment_date,
        delivery_date: delivery_date,
        discount: discount,
        customer_id: customer_id,
        item_service_orders: item_service_orders_not_found
      }
    end

    before(:each) do
      graphql_post(headers: user_headers, params: params_with_invalid_items)
    end

    it 'returns not found item error message' do
      expect(json_response_error_message).to eq("Couldn't find Item with 'id'=-1")
    end

    it 'does not create service order' do
      expect(ServiceOrder.count).to eq(0)
    end
  end

  def query(params)
    items = params[:item_service_orders]
    <<~GQL
      mutation {
        createServiceOrder(
          name: "#{params[:name]}"
          status: "#{params[:status]}"
          extraInformation: "#{params[:extra_information]}"
          accomplishmentDate: "#{params[:accomplishment_date]}"
          deliveryDate: "#{params[:delivery_date]}"
          discount: #{params[:discount]}
          customerId: "#{params[:customer_id]}"
          itemServiceOrders: [
            { itemId: #{items[0][:item_id]}, quantity: #{items[0][:quantity]}},
            { itemId: #{items[1][:item_id]}, quantity: #{items[1][:quantity]}}
          ]
        ) {
          id
          name
          status
          extraInformation
          accomplishmentDate
          deliveryDate
          discount
          customer {
            id
            name
            email
            phone
          }
          itemServiceOrders {
            id
            serviceOrderId
            itemId
            quantity
            salePrice
            purchasePrice
          }
        }
      }
    GQL
  end
end
