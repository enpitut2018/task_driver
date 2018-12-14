class Mutations::CreateClap < GraphQL::Schema::Mutation
  graphql_name 'CreateClapMutation'
  null false

  argument :task_id, ID, required: true

  field :task, Types::TaskType, null: false
  field :errors, [String], null: false

  def resolve(task_id:)
    task = Task.find(task_id)
    count = task.clap + 1
    task.clap = count
    if task.save
      { task: task, errors: [] }
    else
      { task: task, errors: task.errors.full_messages }
    end

    client = User.find(task.user_id)
    body = {
      name: "あなたの頑張りを応援しています！ 応援人数：#{count}人"
    }
    notification(client, body)
  end
end