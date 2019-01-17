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
            uri = URI.parse("https://task-driver.sukiyaki.party/tasks/importance?id=#{client.id}")
            https = Net::HTTP.new(uri.host, uri.port)
            https.use_ssl = true
            https.verify_mode = OpenSSL::SSL::VERIFY_NONE
            res = https.start{
                https.get(uri.path + "?" + uri.query) #resには配列がはいる
            }
            res = JSON.parse(res.body)

            if !(res.empty? || res.nil?)
                body = {
                    name: res[0]["name"] + "が最優先タスクとして残ってるよ！", 
                    id: res[0]["id"], 
                    uid: res[0]["user_id"],
                    gid: res[0]["group_id"],
                    target_url: "/"
                }
                notification(client, body)
            end
        end
    #end
end

task :deadline_notification => :environment do
    today = Time.now #今日締め切りのタスクを検索するための日付

    clients = User.where.not(endpoint: nil, key: nil, auth: nil, encoding: nil).select("id, endpoint, key, auth, encoding")
    clients.each do |client|
        tasks = Task.where("user_id = ? and deadline >= ? and deadline < ?", client.id, Time.new(today.year, today.month, today.day), Time.new(today.year, today.month, today.day+1)).select("id, user_id, group_id, name, deadline")

        if tasks.empty? || tasks.nil?
            next; #今日締め切りのタスクがなければ通知を送らずに終了
        end

        name = ""
        tasks.each do |task|
            if name == ""
                name = task.name
            else
                name += "と#{task.name}"
            end
        end
        body = {
            name: name + "が今日締め切りです！",
            id: tasks[0].id,
            uid: tasks[0].user_id,
            gid: tasks[0].group_id,
            target_url: "/"
        }

        notification(client, body)
    end
end