require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationship' do
    it { should belong_to(:user).required }
    it { should have_many(:service_orders) }
  end

  describe 'validations' do
    describe 'email' do
      it { should allow_value('example@email.com').for(:email) }
      it { should_not allow_value('example.com').for(:email) }
    end

    describe 'phone' do
      it { should validate_numericality_of(:phone).is_greater_than_or_equal_to(Customer::MIN_PHONE_VALUE) }
      it { should validate_numericality_of(:phone).is_less_than_or_equal_to(Customer::MAX_PHONE_VALUE) }
    end

    it { should validate_presence_of(:name) }

    describe 'uniqueness' do
      subject { create(:customer) }
      it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }
      it { should validate_uniqueness_of(:email).scoped_to(:user_id).case_insensitive }
      it { should validate_uniqueness_of(:phone).scoped_to(:user_id).case_insensitive }
    end
  end
end
