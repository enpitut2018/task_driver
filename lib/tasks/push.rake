task :push_notification => :environment do 
    #登録されているすべてのレジストレーションIDを取得
    clients = User.where.not(endpoint: nil, key: nil, auth: nil, encoding: nil).select("endpoint, key, auth, encoding")
    
    clients.each do |client|
        #全てのレジストレーションIDについてcurlを実行
        if client.encoding == 'aes128gcm' then
            jwtHeader = Base64.encode64('{
                "alg":"ES256",
                "typ":"JWT"
                }') #JWTヘッダー
            payload = {
                "aud":"https://fcm.googleapis.com", 
                "exp":1464269795, 
                "sub":"https://task-driver.sukiyaki.party"
              }#JWTクレーム
            token = JWT.encode(payload, ecdsa_key, 'ES256')

            system('curl --header "Authorization: key=' + ENV['FIREBASE_KEY'] + '" --header Content-Type:"application/json" https://fcm.googleapis.com/fcm/send -d "{\"registration_ids\": [\"' + endpoint.endpoint + '\"]}"')   
        elsif client.encoding == 'aesgcm' then
            system('curl --header "Authorization: key=' + ENV['FIREBASE_KEY'] + '" --header Content-Type:"application/json" https://fcm.googleapis.com/fcm/send -d "{\"registration_ids\": [\"' + endpoint.endpoint + '\"]}"')
        end
    end
end