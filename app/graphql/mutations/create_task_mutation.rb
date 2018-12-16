
class Mutations::CreateTaskMutation < GraphQL::Schema::Mutation
    # TODO: define return fields
    # field :post, Types::PostType, null: false

    # TODO: define arguments
    # argument :name, String, required: true

    # TODO: define resolve method
    # def resolve(name:)
    #   { post: ... }
    # end
    graphql_name 'CreateTaskMutation'

    null false
    argument :name, String, 'タスク名', required: true
    argument :deadline, Types::MomentType, 'タスク締め切り', required: true
    argument :importance, Integer, '重要度', required: true
    argument :note, String, 'メモ', required: true
    argument :status, Integer, '進行状態(1: TODO, 2: DOING, 3: DONE)', required: true
    argument :group_id, ID, 'グループID', required: true

    def resolve(name:, deadline:, importance:, note:, status:, group_id:)
        task = Task.new(name: name, deadline: deadline, importance: importance, note: note, status: status, group_id: group_id)

        if task.save
            { task: task, errors: [] }
        else
            {
              errors: task.errors.full_messages
            }
        end
    end

end

