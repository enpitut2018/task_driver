task :push_notification => :environment do 
    #登録されているすべてのレジストレーションIDを取得
    endpoints = User.where.not(endpoint: nil).select("endpoint")
    
    endpoints.each do |endpoint|
        #全てのレジストレーションIDについてcurlを実行
        system('curl --header "Authorization: key=' + ENV[:FIREBASE_KEY] + '" --header Content-Type:"application/json" https://fcm.googleapis.com/fcm/send -d "{\"registration_ids\": [\"' + endpoint.endpoint + '\"]}"')
    end
end