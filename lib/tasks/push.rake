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
            body = {
                name: res[0].name, 
                id: res[0].id, 
                target_url: "/tasks/"
            }

            notification(client, body)
        end
    #end
end

task :deadline_notification => :environment do
    today = Time.now #今日締め切りのタスクを検索するための日付

    tasks = Task.where("deadline >= ? and deadline < ?", Time.new(today.year, today.month, today.day), Time.new(today.year, today.month, today.day+1)).select("user_id, name, deadline")
    ids = Array.new #idを一意に管理する配列
    tasks.each do |task|
        ids.push(task.id) #idを配列に追加する
    end
    ids.uniq! #重複したidをユニークにする

    clients = User.where(id: ids)where.not(endpoint: nil, key: nil, auth: nil, encoding: nil).select("id, endpoint, key, auth, encoding")

    clients.each do |client|
        body = {
            name: 
        }
    end

    notification(client, body)
end