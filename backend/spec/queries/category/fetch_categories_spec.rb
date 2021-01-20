require 'rails_helper'

RSpec.describe Queries::Category::FetchCategories, type: :request do
  let!(:user) { create(:user) }
  let!(:user_headers) { header_for_user(user) }
  let!(:category) { create_list(:category, 1, user: user)[0] }

  describe 'when data is valid' do
    before(:each) do
      graphql_post(headers: user_headers)
    end

    it 'returns categories data' do
      data = json_response('fetchCategories')
      expect(data.length).to eq(1)
      expect(data[0]).to include(
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
