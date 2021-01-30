class Item < ApplicationRecord
  TYPES = %w[product service].freeze

  belongs_to :user
  belongs_to :category
  has_many :item_service_orders, dependent: :destroy

  validates :item_type, presence: true, inclusion: { in: Item::TYPES }
  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :purchase_price, numericality: { greater_than_or_equal_to: 0 }
  validates :sale_price, numericality: { greater_than: 0 }
end
