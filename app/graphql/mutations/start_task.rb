class Mutations::StartTask < GraphQL::Schema::Mutation
  graphql_name 'StartTaskMutation'
  null false

  argument :task_id, ID, required: true

  field :contribution, Types::ContributionType, null: false
  field :errors, [String], null: false

  # 引数にargumentが入ってくるのはqueryと同じ挙動
  def resolve(task_id:)
    task = Task.find(task_id)
    task.status = 2
    contribution = Contribution.create(:user_id => context[:current_user].id)
    if contribution.save
      { contribution: contribution, errors: [] }
    else
      {
        contribution: contribution,
        errors: contribution.errors.full_messages
      }
    end
  end
end