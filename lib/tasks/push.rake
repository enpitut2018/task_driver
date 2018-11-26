task :push_notification => :environment do 
    hour = DateTime.now.hour
    if(!(hour > 1 && hour < 7)) then
        #エンドポイントが登録されているすべてのユーザを取得
        clients = User.where.not(endpoint: nil, key: nil, auth: nil, encoding: nil).select("id, endpoint, key, auth, encoding")
        
        clients.each do |client|
            
            #各ユーザーの最重要タスクを取得
            Net::HTTP.start('/') {|http|
                res = JSON.parse(http.get('/tasks/importance')) #resには配列がはいる
            }

            #全てのエンドポイントについてcurlを実行
            payload = {
                endpoint: 'https://fcm.googleapis.com/fcm/send/client.endpoint', # ブラウザでregistration.pushManager.getSubscription()で取得したsubscriptionのendpoint
                p256dh: client.key, # 同じくsubscriptionのp256dh
                auth: client.auth, # 同じくsubscriptionのauth
                ttl: 86400, # 任意の値
                vapid: {
                    subject: 'https://task-driver.sukiyaki.party', # APPサーバのコンタクト用URIとか('mailto:' もしくは 'https://')
                    public_key: ENV['VAPID_PUBLIC_KEY'],
                    private_key: ENV['VAPID_SECRET_KEY']
                },
                message: {
                    title: "task",
                    body: {
                        name: res[0].name,
                        id: res[0].id,
                        target_url: "/tasks/"
                    }
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

            group = OpenSSL::PKey::EC::Group.new('prime256v1')
            client_public_key_bn = OpenSSL::BN.new(Base64.urlsafe_decode64(client.key), 2)
            client_public_key = OpenSSL::PKey::EC::Point.new(group, client_public_key_bn) #クライアント公開鍵を元にEC::Pointオブジェクトを生成

            shared_key = payload_key.dh_compute_key(client_public_key) #共有鍵を生成
            
            auth_token = Base64.urlsafe_decode64(client.auth)

            salt = Random.new.bytes(16) #HKDF暗号に使うsaltを生成
            prk = HKDF.new(shared_key, salt: auth_token, algorithm: 'SHA256', info: "Content-Encoding: aes128gcm\0").next_bytes(32)


            system("
                curl -v -X POST
                    -H \"Authorization: vapid t=#{token},k=#{Base64.encode64(ENV['VAPID_PUBLIC_KEY'])}\" 
                    -H \"Content-Encoding: aes128gcm\" 
                    -H \"TTL: 86400\" 
                    -H \"\" 
                    https://fcm.googleapis.com/wp/#{client.endpoint}
            ")
=end
        end
    end
end