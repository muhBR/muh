require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationship' do
    it { should have_many(:items) }
    it { should have_many(:categories) }
  end

  describe 'validations' do
    describe 'email' do
      it { should validate_uniqueness_of(:email) }
      it { should validate_presence_of(:email) }
      it { should allow_value('example@email.com').for(:email) }
      it { should_not allow_value('example.com').for(:email) }
    end

    describe 'password' do
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(6) }
    end
  end
end
