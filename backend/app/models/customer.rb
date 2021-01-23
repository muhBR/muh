class Customer < ApplicationRecord
  MIN_PHONE_VALUE = 100_000_000
  MAX_PHONE_VALUE = 99_999_999_999

  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :phone, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :email, uniqueness: { scope: :user_id, case_sensitive: false }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, numericality: { greater_than_or_equal_to: MIN_PHONE_VALUE, less_than_or_equal_to: MAX_PHONE_VALUE }
end
