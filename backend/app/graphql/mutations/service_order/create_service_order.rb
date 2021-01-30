module Mutations::ServiceOrder
  class CreateServiceOrder < Mutations::Generic::CreateMutation
    self.resource_class = ServiceOrder

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
      service_order = ServiceOrder.new(create_params(params))
      service_order.user = context[:current_user]

      item_service_orders = ItemServiceOrder.build_from_items_list(service_order, params[:item_service_orders])

      ServiceOrder.transaction do
        service_order.save!
        item_service_orders.each(&:save!)
      end

      service_order
    end

    private

    def create_params(params)
      params.except(:item_service_orders)
    end
  end
end
