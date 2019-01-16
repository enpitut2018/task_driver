class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController  
  
  def twitter
    callback_from :twitter
  end

  def redirect
    request_token_url = 'https://twitter.com/oauth/request_token'
    access_token_url = 'https://twitter.com/oauth/access_token'
    
    authenticate_url = 'https://twitter.com/oauth/authenticate'
    consumer = OAuth::Consumer.new(
      ENV['TWITTER_CONSUMER_KEY'],
      ENV['TWITTER_CONSUMER_SECRET'],
      :site => 'https://api.twitter.com',
    )
    
    @callback_url = ENV['APPLICATION_FRONT_URL'] + "/oauth/callback/login"
    request_token = consumer.get_request_token(:oauth_callback => @callback_url)
    url = {url: request_token.authorize_url(:oauth_callback => @callback_url)}
    
    respond_to do |format|
      # format.html
      format.json {render :json => url}
      # format.xml  {render :xml => オブジェクト}
    end

  end

  def callbacklogin
    uri = URI.parse("https://api.twitter.com/oauth/access_token")
    http = Net::HTTP.new(uri.host, uri.port)
    
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Post.new(uri.path)
    req.set_form_data({'oauth_consumer_key' => ENV['TWITTER_CONSUMER_KEY'], 'oauth_token' => post_params[:oauth_token], 'oauth_verifier' => post_params[:oauth_verifier]})
    res = http.request(req)

    tokens = {}
    res.body.split('&').each do |line|
        result = line.split('=')
        tokens[result[0]] = result[1]
    end

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = tokens["oauth_token"]
      config.access_token_secret = tokens["oauth_token_secret"]
    end

    userinfo = client.user
    @user = User.find_for_oauth(userinfo)

    unless Oauth.find_by(user_id: @user.id)
      @oauth = Oauth.new(user_id: @user.id, access_token: tokens["oauth_token"], access_token_secret: tokens["oauth_token_secret"])
      @oauth.save
    end

    if @user.persisted?
      sign_in @user

      #jwtを返す...まだ返せていない
      render json: {success: true, token: current_token, response: "Authentication successful" }

    else
      @user.save
      sign_in @user

      #jwtを返す
      render json: {success: true, token: current_token, response: "Authentication successful" }
    end
  end

  def show
    respond_to :json
  end

  private
  def current_token
  	request.env['warden-jwt_auth.token']
  end

  private
  def post_params
    # モデル作成に必要な引数を指定
    params.require(:user).permit(
      :oauth_token, :oauth_verifier
    )
  end
end