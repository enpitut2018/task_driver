
class Mutations::CreateTaskMutation < GraphQL::Schema::Mutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    graphql_name 'CreateTask'

    null false
    argument :name, String, 'タスク名', required: true
    
    # MomentTypeの仕様がわかりません...一時的にString型にしておきます。
    # argument :deadline, Types::MomentType, 'タスク締め切り', required: true
    argument :deadline, String, 'タスク締め切り', required: true
    argument :importance, Integer, '重要度', required: true
    argument :note, String, 'メモ', required: false
    argument :status, Integer, '進行状態(1: TODO, 2: DOING, 3: DONE)', required: true
    argument :group_id, ID, 'グループID', required: true
    argument :user_id, ID, "ユーザーID", required: true

    field :task, Types::TaskType, null: false
    field :errors, [String], null: false

    def resolve(name:, deadline:, importance:, note:, status:, group_id:, user_id:)
        task = Task.new(name: name, deadline: deadline, importance: importance, note: note, status: status, group_id: group_id, user_id: user_id)

        if task.save
            { task: task, errors: [] }
        else
            {
              errors: task.errors.full_messages
            }
        end
    end

end

