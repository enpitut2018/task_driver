class Mutations::StartContribution < GraphQL::Schema::Mutation
  graphql_name 'StartContributionMutation'
  null false

  argument :task_id, ID, required: true

  field :task, Types::TaskType, null: true
  field :contribution, Types::ContributionType, null: true
  field :errors, [String], null: false

  def resolve(task_id:)
    task = Task.find(task_id)
    contribution = Contribution.new(:user_id => context[:current_user].id, :task_id => task.id)
    if task.user_id != context[:current_user].id
      return { contribution: contribution, task: task, errors: ['specified task is not yours.'] }
    end
    if contribution.save && task.doing!
      { contribution: contribution, task: task, errors: [] }
    else
      {
        contribution: contribution,
        errors: contribution.errors.full_messages
      }
    end
  end
end