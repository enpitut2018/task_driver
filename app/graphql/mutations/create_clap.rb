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

class Mutations::CreateClap < GraphQL::Schema::Mutation
  graphql_name 'CreateClapMutation'
  null false

  argument :task_id, ID, required: true

  field :task, Types::TaskType, null: false
  field :errors, [String], null: false

  def resolve(task_id:)
    task = Task.find(task_id)
    client = User.find(task.user_id)
    count = task.clap + 1
    task.clap = count
    if task.save
      { task: task, errors: [] 
        body = {
          name: task.name,
          target_url: "/"
        }
        notification(client, body)
        }
    else
      { task: task, errors: task.errors.full_messages }
    end
  end
end