require 'rails_helper'

RSpec.describe ServiceOrder, type: :model do
  describe 'relationship' do
    it { should belong_to(:user).required }
    it { should belong_to(:customer).required }
    it { should have_many(:item_service_orders) }
  end

  describe 'validations' do
    subject { create(:service_order) }

    describe 'inclusion' do
      it { expect(subject).to validate_inclusion_of(:status).in_array(ServiceOrder::STATUSES) }
    end

    it { should validate_presence_of(:name) }
  end
end
