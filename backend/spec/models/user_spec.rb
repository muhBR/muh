require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
    it { should allow_value('example@email.com').for(:email) }
    it { should_not allow_value('example.com').for(:email) }
  end
end
