Mutations::CreateCrapMutation = GraphQL::Relay::Mutation.define do
  name "CreateCrapMutation"

  input_field :task_id, !types.ID

  return_field :task, !Types::TaskType


  resolve ->(obj, args, ctx) {
  	begin
      task = Task.find(inputs.tsak_id)
      task.crap += 1
    rescue => e
      return GraphQL::ExecutionError.new(e.message)
    end

    { task: task }
  }
end