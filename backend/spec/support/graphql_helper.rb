module GraphqlHelper
  def graphql_post(**query_args)
    post '/graphql', params: { query: query(**query_args) }
  end

  def json_response(field_name)
    JSON.parse(response.body)['data'][field_name]
  end

  def json_response_error_message
    JSON.parse(response.body)['errors'][0]['message']
  end
end
