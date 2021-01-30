require 'rails_helper'

RSpec.describe ItemServiceOrder, type: :model do
  describe 'relationship' do
    it { should belong_to(:item).required }
    it { should belong_to(:service_order).required }
  end

  describe 'numericality' do
    it { should validate_numericality_of(:purchase_price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:sale_price).is_greater_than(0) }
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe '#build_from_items_list!' do
    describe 'when data is valid' do
      let(:service_order) { build(:service_order) }
      let(:items) { create_list(:item, 2) }
      let(:item_quantities) { [1, 2] }
      let(:item_service_orders) do
        [
          {
            item_id: items[0].id,
            quantity: item_quantities[0]
          },
          {
            item_id: items[1].id,
            quantity: item_quantities[1]
          }
        ]
      end

      subject { ItemServiceOrder.build_from_items_list(service_order, item_service_orders) }

      it { expect(subject.count).to eq(2) }

      it 'matches data' do
        expect(subject[0].service_order).to eq(service_order)
        expect(subject[0].item).to eq(items[0])
        expect(subject[0].quantity).to eq(item_quantities[0])
        expect(subject[0].sale_price).to eq(items[0].sale_price)

        expect(subject[1].service_order).to eq(service_order)
        expect(subject[1].item).to eq(items[1])
        expect(subject[1].quantity).to eq(item_quantities[1])
        expect(subject[1].sale_price).to eq(items[1].sale_price)
      end
    end

    describe 'when data is not valid' do
      let(:service_order) { build(:service_order) }
      let(:items) { create_list(:item, 2) }
      let(:item_quantities) { [0, 2] }
      let(:item_service_orders) do
        [
          {
            item_id: items[0].id,
            quantity: item_quantities[0]
          },
          {
            item_id: items[1].id,
            quantity: item_quantities[1]
          }
        ]
      end

      subject { ItemServiceOrder.build_from_items_list(service_order, item_service_orders) }

      it {
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Quantity must be greater than 0')
      }
    end
  end
end
