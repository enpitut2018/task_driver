task :push_notification => :environment do 
    #登録されているすべてのレジストレーションIDを取得
    endpoints = User.where.not(endpoint: nil).select("endpoint")
    
    endpoints.each do |endpoint|
        #全てのレジストレーションIDについてcurlを実行
        system('curl --header "Authorization: key=AIzaSyBmfJV9ZBnUu3n3pu1kW0uier7XT8HBnHo" --header Content-Type:"application/json" https://fcm.googleapis.com/fcm/send -d "{\"registration_ids\": [\"' + endpoint.endpoint + '\"]}"')
    end
end