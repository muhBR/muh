require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationship' do
    it { should belong_to(:user).required }
    it { should belong_to(:category).required }
    it { should have_many(:item_service_orders) }
  end

  describe 'validations' do
    subject { create(:item) }

    describe 'inclusion' do
      it { expect(subject).to validate_inclusion_of(:item_type).in_array(Item::TYPES) }
    end

    describe 'presence' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:item_type) }
    end

    describe 'uniqueness' do
      it { should validate_uniqueness_of(:name).scoped_to(:user_id).case_insensitive }
    end

    describe 'numericality' do
      it { should validate_numericality_of(:purchase_price).is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:sale_price).is_greater_than(0) }
    end
  end
end
