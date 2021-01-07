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
  describe 'when data is not valid' do
    let(:invalid_email) { 'invalid_email.com' }
    let(:valid_password) { 'secret' }

    subject do
      perform(email: invalid_email, password: valid_password)
    end

    it { is_expected.to be_a(GraphQL::ExecutionError) }

    it 'returns with proper data' do
      expect(subject.message).to eq('Invalid input: Email is invalid')
    end
  end
end
