class ServiceOrder < ApplicationRecord
  STATUSES = %w[to_do doing done].freeze

  belongs_to :user
  belongs_to :customer
  has_many :item_service_orders, dependent: :destroy

  validates :name, presence: true
  validates :status, presence: true, inclusion: { in: ServiceOrder::STATUSES }
end
