class Mutations::StartTask < GraphQL::Schema::Mutation
  name 'StartTaskMutation'
  null false

  argument :task_id, ID, required: true

  field :contribution, Types::ContributionType, null: false
  field :errors, [String], null: false

  # 引数にargumentが入ってくるのはqueryと同じ挙動
  def resolve(id:)
    task = Task.find(id)
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