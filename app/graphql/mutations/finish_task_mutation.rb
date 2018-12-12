Mutations::FinishTaskMutation = GraphQL::Relay::Mutation.define do
  name "FinishTaskMutation"

  input_field :task_id, !types.ID
  input_field :is_finish?, !types.Boolean
  input_field :contribution_id, !types.ID

  return_field :task, !Types::TaskType

  resolve ->(obj, args, ctx) {
  	begin
      task = Task.find(inputs.task_id)
      contribution = Contribution.find(inputs.contribution_id)

      if inputs.is_finish?
      	task.status = 1
      	contribution.finish_time = DateTime.now
      	contribution.is_finish? = true
      else
      	task.status = 3
      	contribution.finish_time = DateTime.now
      	contribution.is_finish? = false
      end

    rescue => e
      return GraphQL::ExecutionError.new(e.message)
    end

    { task: task }

  }
end


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