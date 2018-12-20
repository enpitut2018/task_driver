class Mutations::CreateRedirecturlMutation < GraphQL::Schema::Mutation
  graphql_name 'CreateRedirecturlMutation'
  null false

  # argument :id, ID, required: true

  # field :task, Types::TaskType, null: true
  field :url, String, null: true
  # field :contribution, Types::ContributionType, null: true
  # field :errors, [String], null: false

  def resolve()
    request_token_url = 'https://twitter.com/oauth/request_token'
    access_token_url = 'https://twitter.com/oauth/access_token'
    
    authenticate_url = 'https://twitter.com/oauth/authenticate'
    consumer = OAuth::Consumer.new(
      ENV['TWITTER_CONSUMER_KEY'],
      ENV['TWITTER_CONSUMER_SECRET'],
      :site => 'https://api.twitter.com',
    )
    
    @callback_url = ENV['APPLICATION_FRONT_URL'] + "/oauth/callback"
    request_token = consumer.get_request_token(:oauth_callback => @callback_url)
    {url: request_token.authorize_url(:oauth_callback => @callback_url)}
    
  end
end