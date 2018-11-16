task :push_notification => :environment do 
    #エンドポイントが登録されているすべてのユーザを取得
    clients = User.where.not(endpoint: nil, key: nil, auth: nil, encoding: nil).select("username, endpoint, key, auth, encoding")
    
    clients.each do |client|
        #全てのエンドポイントについてcurlを実行
        if client.encoding == 'aes128gcm' then

            payload = {
                endpoint: client.endpoint, # ブラウザでregistration.pushManager.getSubscription()で取得したsubscriptionのendpoint
                p256dh: client.key, # 同じくsubscriptionのp256dh
                auth: client.auth, # 同じくsubscriptionのauth
                ttl: 86400, # 任意の値
                vapid: {
                    subject: 'https://task-driver.sukiyaki.party', # APPサーバのコンタクト用URIとか('mailto:' もしくは 'https://')
                    public_key: ENV['VAPID_PUBLIC_KEY'],
                    private_key: ENV['VAPID_SECRET_KEY']
                },
                message: {
                    icon: 'https://example.com/images/demos/icon-512x512.png',
                    title: "今暇？",
                    body: client.username,
                    target_url: "https://fcm.googleapis.com/wp/#{client.endpoint}" # 任意のキー、値
                }.to_json
            }
            Webpush.payload_send(payload) #送信


            =begin
            jwtClaim = {
                "aud":"https://fcm.googleapis.com", 
                "exp":1464269795, 
                "sub":"https://task-driver.sukiyaki.party"
              }#JWTクレーム
            token = JWT.encode(jwtClaim, ecdsa_key, 'ES256') #JTWを作成
            
            payload_key = OpenSSL::PKey::EC.new('prime256v1')
            payload_key.generate_key #メッセージ暗号化用の鍵ペアを生成（使い捨て）
            client_key = OpenSSL::PKey::EC.new(client.key) #クライアント公開鍵をもとにECオブジェクトを生成
            shared_key = payload_key.dh_compute_key(client_key) #共有鍵を生成
            

            system("
                curl -v -X POST
                    -H \"Authorization: vapid t=#{token},k=#{Base64.encode64(ENV['VAPID_PUBLIC_KEY'])}\" 
                    -H \"Content-Encoding: aes128gcm\" 
                    -H \"TTL: 86400\" 
                    -H \"\" 
                    https://fcm.googleapis.com/wp/#{client.endpoint}
            ")
            =end

        elsif client.encoding == 'aesgcm' then
            system('curl --header "Authorization: key=' + ENV['FIREBASE_KEY'] + '" --header Content-Type:"application/json" https://fcm.googleapis.com/fcm/send -d "{\"registration_ids\": [\"' + endpoint.endpoint + '\"]}"')
        end
    end
end