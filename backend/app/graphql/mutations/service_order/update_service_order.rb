module Mutations::ServiceOrder
  class UpdateServiceOrder < Mutations::Generic::UpdateMutation
    self.resource_class = ServiceOrder

    argument :id, ID, required: true
    argument :name, String, required: true
    argument :status, String, required: true
    argument :extra_information, String, required: false
    argument :accomplishment_date, String, required: false
    argument :delivery_date, String, required: false
    argument :discount, Float, required: false

    argument :customer_id, ID, required: true

    argument :item_service_orders, [Types::Input::ItemServiceOrderInput], required: false

    type Types::Model::ServiceOrderType

    def resolve(params)
      service_order = ServiceOrder.find_by(id: params[:id], user: context[:current_user])

      ServiceOrder.transaction do
        service_order.update!(update_params(params))
        update_item_service_orders!(params, service_order.item_service_orders)
      end

      service_order.reload
    end

    private

    def update_params(params)
      params.except(:item_service_orders)
    end

    def update_item_service_orders!(params, item_service_orders)
      item_service_orders_hash = params[:item_service_orders]

      item_service_orders.each do |item_service_order|
        item_service_order_hash = item_service_orders_hash.detect { |i| i[:item_id].to_i == item_service_order.item_id }
        if item_service_order_hash.present?
          item_service_order.quantity = item_service_order_hash[:quantity].to_i
          item_service_order.save!
        end
      end
    end
  end
end
