class Mutations::DeleteTask < GraphQL::Schema::Mutation
  graphql_name 'DeleteTaskMutation'
  null false

  argument :task_id, ID, description: 'タスクID', required: true

  field :task, Types::TaskType, null: false
  field :errors, [String], null: false

  def resolve(task_id:)
    task = Task.find(task_id)

    if task.destroy
      { task: task, errors: [] }
    else
      { task: task, errors: task.errors.full_messages }
    end
  end
end