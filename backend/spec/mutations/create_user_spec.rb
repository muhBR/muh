require 'rails_helper'

RSpec.describe Mutations::CreateUser do
  def perform(**args)
    Mutations::CreateUser.new(object: nil, field: nil, context: {}).resolve(**args)
  end

  describe 'when data is valid' do
    let(:valid_email) { 'email@gmail.com' }
    let(:valid_password) { 'secret' }

    subject do
      perform(email: valid_email, password: valid_password)
    end

    it { is_expected.to be_a(User) }

    it { is_expected.to be_persisted }

    it 'returns with proper data' do
      expect(subject.email).to eq(valid_email)
      expect(subject.id).to_not be_nil
    end
  end
end
