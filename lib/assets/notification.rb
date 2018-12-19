#####################################################################################
#####################################################################################
#第一引数のclientにはcurrent_user.idとかでユーザーモデルを検索した結果のActiveRecordsを
#第二引数のbodyには{name: "hoge"}みたいな形でjsonっぽく書いた文字列を渡してください
#####################################################################################
#####################################################################################

=begin
def notification(client, body)
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
            body: body
        }.to_json
    }
    Webpush.payload_send(payload) #送信
end
=end