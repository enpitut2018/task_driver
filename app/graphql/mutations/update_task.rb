class Mutations::UpdateTask < GraphQL::Schema::Mutation
  graphql_name 'UpdateTaskMutation'
  null false

  argument :task_id, ID, description: 'タスクID', required: true
  argument :name, String, description: 'タスク名', required: false
  argument :deadline, Types::MomentInputType, description: '締め切り', required: false
  argument :importance, Integer, description: '重要度', required: false
  argument :note, String, description: 'メモ', required: false
  argument :group_id, ID, description: 'グループID', required: false

  field :task, Types::TaskType, null: false
  field :errors, [String], null: false

  def resolve(task_id:, name:, deadline:, importance:, group_id:, note:)
    deadline = DateTime.new(deadline.year, deadline.month, deadline.day, deadline.hour, deadline.minute, deadline.second)
    task = Task.find(task_id)

    if task.user_id != context[:current_user].ID
      return { task: task, errors: ['specified task is not yours.'] }
    end

    task.name = name if !name.nil?
    task.deadline = daeadline if !deadline.nil?
    task.importance = importance if !importance.nil?
    task.group_id = group_id if !group_id.nil?
    task.note = note if !note.nil?

    if task.save
      { task: task, errors: [] }
    else
      { task: task, errors: task.errors.full_messages }
    end
  end
end