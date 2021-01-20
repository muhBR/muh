class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  before_action :fetch_current_user
  GRAPHQL_DEFINITIONS = %w[__schema
                           kind
                           name
                           description
                           fields
                           inputFields
                           interfaces
                           enumValues
                           possibleTypes
                           name
                           description
                           type
                           defaultValue
                           kind
                           name
                           ofType].freeze

  PUBLIC_MUTATIONS = %w[
    createUser
    signIn
    IntrospectionQuery
  ].freeze

  PUBLIC_ACTIONS = GRAPHQL_DEFINITIONS + PUBLIC_MUTATIONS

  def execute
    if public_query? || authenticated?
      context = { current_user: current_user }
      result = BackendSchema.execute(params[:query], context: context)
      render json: result
    else
      render_unauthorized
    end
  end

  private

  def public_query?
    private_mutations = query_mutations - PUBLIC_ACTIONS
    private_mutations.empty?
  end

  def query_mutations
    mutations = []
    queries = GraphQL.parse(params[:query]).definitions
    queries.each do |query|
      query.selections.each do |selection|
        mutations.push selection.name
      end
    end
    mutations
  end
end
