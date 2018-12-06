task :push_notification => :environment do 
    hour = DateTime.now.hour
    #if(!(hour > 1 && hour < 7)) then
        #エンドポイントが登録されているすべてのユーザを取得
        clients = User.where.not(endpoint: nil, key: nil, auth: nil, encoding: nil).select("id, endpoint, key, auth, encoding")
        
        clients.each do |client|
            
            #各ユーザーの最重要タスクを取得
            Net::HTTP.start('/') {|http|
                res = JSON.parse(http.get("/tasks/importance?id=#{client.id}")) #resには配列がはいる
            }

            #全てのエンドポイントについてcurlを実行
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
                    title: "task",
                    body: {
                        name: res[0].name,
                        id: res[0].id,
                        target_url: "/tasks/"
                    }
                }.to_json
            }
            Webpush.payload_send(payload) #送信
        end
    #end
end