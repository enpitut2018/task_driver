class Mutations::FinishContribution < GraphQL::Schema::Mutation
  graphql_name 'FinishContributionMutation'
  null false

  argument :contribution_id, ID, required: true
  argument :finality, Boolean, required: true

  field :task, Types::TaskType, null: true
  field :contribution, Types::ContributionType, null: true
  field :errors, [String], null: false

  def resolve(contribution_id:, finality:)
    contribution = Contribution.find(contribution_id)
    task = Task.find(contribution.task_id)

    contribution.status = 'inactive'
    contribution.finished_at = DateTime.now
    
    if finality
      contribution.finality = 'final'
      task.status = 'done'
    else
      contribution.finality = 'not_final'
      task.status = 'todo'
    end

    if contribution.save && task.save
      { contribution: contribution, task: task, errors: [] }
    else
      {
        contribution: contribution,
        errors: contribution.errors.full_messages
      }
    end
  end
end