class User < ApplicationRecord
  has_secure_password

  has_many :items, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :service_orders, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
end
