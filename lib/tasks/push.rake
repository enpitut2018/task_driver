task :push_notification => :environment do 
    hour = DateTime.now.hour
    #if(!(hour > 1 && hour < 7)) then
        #エンドポイントが登録されているすべてのユーザを取得
        clients = User.where.not(endpoint: nil, key: nil, auth: nil, encoding: nil).select("id, endpoint, key, auth, encoding")

        clients.each do |client|
            #各ユーザーの最重要タスクを取得
            https = Net::HTTP.new('/', 443)
            https.use_ssl = true
            https.verify_mode = OpenSSL::SSL::VERIFY_NONE
            https.start{
                res = JSON.parse(http.get("/tasks/importance?id=#{client.id}")) #resには配列がはいる
            }
            body = {
                name: res[0].name + "が最優先タスクとして残ってるよ！", 
                id: res[0].id, 
                target_url: "/tasks/"

            }

            notification(client, body)
        end
    #end
end

task :deadline_notification => :environment do
    today = Time.now #今日締め切りのタスクを検索するための日付

    clients = User.where.not(endpoint: nil, key: nil, auth: nil, encoding: nil).select("id, endpoint, key, auth, encoding")
    clients.each do |client|
        tasks = Task.where("user_id = ? and deadline >= ? and deadline < ?", client.id, Time.new(today.year, today.month, today.day), Time.new(today.year, today.month, today.day+1)).select("name, deadline")

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
            name: name + "が今日締め切りです！"
        }

        notification(client, body)
    end
end