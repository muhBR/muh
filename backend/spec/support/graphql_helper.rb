module GraphqlHelper
  def graphql_post(**args)
    query_args = args.except(:headers)

    post '/graphql', params: { query: query(**query_args) }, headers: args[:headers]
  end

  def json_response(field_name)
    JSON.parse(response.body)['data'][field_name]
  end

  def json_response_error_message
    JSON.parse(response.body)['errors'][0]['message']
  end

  def header_for_user(user)
    { 'Authorization' => encode_user(user) }
  end
end
