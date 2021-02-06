require 'rails_helper'

RSpec.describe 'GraphqlController', type: :request do
  let(:correct_password) { 'secret1' }
  let!(:user) { create(:user, password: correct_password) }
  let!(:variables) do
    { email: user.email, password: correct_password }
  end

  describe 'when use only query' do
    before(:each) { graphql_post(params: { email: user.email, password: correct_password }) }
    it { expect(response).to have_http_status(:ok) }
  end

  describe 'when use query and variables' do
    before(:each) { post '/graphql', params: { query: query_with_variables, variables: variables } }
    it { expect(response).to have_http_status(:ok) }
  end

  describe 'when use variables as json string' do
    before(:each) { post '/graphql', params: { query: query_with_variables, variables: variables.to_json } }
    it { expect(response).to have_http_status(:ok) }
  end

  describe 'when use variables as empty string' do
    before(:each) { post '/graphql', params: { query: query_with_variables, variables: '' } }
    it { expect(response).to have_http_status(:ok) }
  end

  def query_with_variables
    <<~GQL
      mutation signIn($email: String!,$password: String!){
        signIn(email: $email, password: $password) {
            id
            email
            token
        }
      }
    GQL
  end

  def query(email:, password:)
    <<~GQL
      mutation {
        signIn(
          email: "#{email}"
          password: "#{password}"
        ) {
          id
          email
          token
        }
      }
    GQL
  end
end
