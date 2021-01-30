class ItemServiceOrder < ApplicationRecord
  belongs_to :item
  belongs_to :service_order

  validates :purchase_price, numericality: { greater_than_or_equal_to: 0 }
  validates :sale_price, numericality: { greater_than: 0 }
  validates :quantity, numericality: { greater_than: 0 }

  def self.build_from_items_list(service_order, item_ids_and_quantities)
    item_ids_and_quantities ||= []
    item_service_orders = []

    item_ids_and_quantities.each do |item_id_and_quantity|
      item = Item.find(item_id_and_quantity[:item_id])
      item_service_order = ItemServiceOrder.new(
        service_order: service_order,
        item: item,
        quantity: item_id_and_quantity[:quantity],
        purchase_price: item.purchase_price,
        sale_price: item.sale_price
      )

      raise ActiveRecord::RecordInvalid, item_service_order unless item_service_order.valid?

      item_service_orders.push(item_service_order)
    end

    item_service_orders
  end
end
