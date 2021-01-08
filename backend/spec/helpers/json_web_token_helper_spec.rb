# require JsonWebTokenHelper
require 'rails_helper'

RSpec.describe JsonWebTokenHelper, type: :helper do
  describe '#decoded_user' do
    let(:user) { User.create(email: 'example@gmail.com', password: 'secret1') }
    let(:token) { encode_user user }

    describe 'when token is valid' do
      it 'returns user by token' do
        decoded_user = user_by_token(token)
        expect(decoded_user).to eq(user)
      end
    end

    describe 'when token is not valid' do
      it 'returns nil' do
        decoded_user = user_by_token('invalid_token')
        expect(decoded_user).to be_nil
      end
    end
  end
end
