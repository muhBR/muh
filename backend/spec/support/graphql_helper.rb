module GraphqlHelper
  def graphql_post(**args)
    post '/graphql', params: { query: query(**args[:params]) }, headers: args[:headers]
  end

  def json_response(field_name)
    resonse_body = response.body

    raise "Response body has no 'data' #{resonse_body}" if JSON.parse(resonse_body)['data'].nil?

    JSON.parse(resonse_body)['data'][field_name]
  end

  def json_response_error_message
    JSON.parse(response.body)['error_message']
  end

  def header_for_user(user)
    { 'Authorization' => encode_user(user) }
  end
end
