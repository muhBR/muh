require 'rails_helper'

RSpec.describe Queries::Category::FetchCategories, type: :request do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:user_headers2) { header_for_user(user2) }
  let!(:category) { create_list(:category, 1, user: user)[0] }
  let!(:category2) { create_list(:category, 1, user: user2)[0] }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers, params: {})
    end

    subject { json_response('fetchCategories') }

    it 'returns categories quantity by token user' do
      expect(subject.length).to eq(1)
    end

    it 'returns categories data' do
      expect(subject[0]).to include(
        'id' => category.id.to_s,
        'name' => category.name,
        'userId' => user.id.to_s
      )
    end
  end

  def query
    <<~GQL
      {
        fetchCategories
        {
          id
          name
          userId
        }
      }
    GQL
  end
end
