Mutations::StartTaskMutation = GraphQL::Relay::Mutation.define do
  name "StartTaskMutation"

  input_field :task_id, !types.ID

  return_field :contribution, !Types::ContributionType

  resolve ->(obj, args, ctx) {
  	begin
      task = Task.find(inputs.task_id)
      task.status = 2
      contribution = Contribution.create(:user_id => ctx[:current_user_id], :task_id => inputs.task_id)
      contribution.save
    rescue => e
      return GraphQL::ExecutionError.new(e.message)
    end

    { contribution: contribution }

  }
end