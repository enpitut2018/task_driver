class Mutations::CreateOauthMutation < GraphQL::Schema::Mutation
  graphql_name 'CreateOauthMutation'
  null false

  argument :oauth_token, String, description: 'oauth_token', required: true
  argument :oauth_verifier, String, description: 'oauth_verifier', required: true

  field :oauth, String, null: true

  def resolve(oauth_token:, oauth_verifier:)
    uri = URI.parse("https://api.twitter.com/oauth/access_token")
    http = Net::HTTP.new(uri.host, uri.port)
    
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({'oauth_consumer_key' => ENV['TWITTER_CONSUMER_KEY'], 'oauth_token' => oauth_token, 'oauth_verifier' => oauth_verifier})
    res = http.request(req)

    tokens = {}
    json.split('&').each do |line|
        result = line.split('=')
        tokens[result[0]] = result[1]
    end
    
    @oauth = Oauth.new(user_id: context[:current_user].id, access_token: tokens["oauth_token"], access_token_secret: tokens["oauth_token_secret"])
    @oauth.save

    {oauth: res.body}
  end
end