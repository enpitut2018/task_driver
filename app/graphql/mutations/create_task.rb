class Mutations::CreateTask < GraphQL::Schema::Mutation
  graphql_name 'CreateTaskMutation'
  null false

  argument :name, String, description: '作成タスク名', required: true
  argument :deadline, Types::MomentInputType, description: '締め切り', required: true
  argument :importance, Integer, description: '重要度', required: true
  argument :note, String, description: 'メモ', required: false
  argument :group_id, ID, description: 'グループID', required: true

  field :task, Types::TaskType, null: false
  field :errors, [String], null: false

  def resolve(name:, deadline:, importance:, group_id:, note:)
    deadline = DateTime.new(deadline.year, deadline.month, deadline.day, deadline.hour, deadline.minute, deadline.second)
    task = Task.new(:name => name, :deadline => deadline, :importance => importance, :group_id => group_id, :user_id => context[:current_user].id, :note => note)
    if task.save
      { task: task, errors: [] }
    else
      { task: task, errors: task.errors.full_messages }
    end
  end
end