class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session
  before_action :authorize_request
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
      begin
        query = params[:query]
        operation_name = params[:operationName]
        context = {
          current_user: current_user
        }
        result = BackendSchema.execute(query, context: context, operation_name: operation_name)
        render json: result
      rescue StandardError => e
        raise e unless Rails.env.development?

        handle_error_in_development e
      end
    else
      render json: { error_message: 'unauthorized :(' }, status: :unauthorized
    end
  end

  private

  def handle_error_in_development(exc)
    logger.error exc.message
    logger.error exc.backtrace.join("\n")

    render json: { errors: [{ message: exc.message, backtrace: exc.backtrace }], data: {} }, status: :internal_server_error
  end

  def public_query?
    private_mutations = query_mutations - PUBLIC_ACTIONS
    private_mutations.empty?
  end

  def authenticated?
    current_user.present?
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
