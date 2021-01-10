require 'rails_helper'

RSpec.describe Mutations::SignIn do
  let(:correct_password) { 'secret1' }
  let!(:user) { create(:user, password: correct_password) }

  def perform(**args)
    Mutations::SignIn.new(object: nil, field: nil, context: {}).resolve(**args)
  end

  describe 'when data is valid' do
    subject do
      perform(email: user.email, password: correct_password)
    end

    it { is_expected.to eq(user) }
  end

  describe 'when data is not valid' do
    describe 'When email is invalid' do
      subject do
        perform(email: 'invalid_email@gmail.com', password: correct_password)
      end

      it 'returns error message' do
        expect(subject.message).to eq('Unauthorized :(')
      end
    end

    describe 'When password is invalid' do
      subject do
        perform(email: user.email, password: 'wrong_password')
      end

      it 'returns error message' do
        expect(subject.message).to eq('Unauthorized :(')
      end
    end
  end
end
