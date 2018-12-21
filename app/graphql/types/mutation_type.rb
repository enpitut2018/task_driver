class Types::MutationType < GraphQL::Schema::Object

  field :startContribution, mutation: Mutations::StartContribution
  field :finishContribution, mutation: Mutations::FinishContribution

  field :createTask, mutation: Mutations::CreateTask
  field :updateTask, mutation: Mutations::UpdateTask
  field :deleteTask, mutation: Mutations::DeleteTask

  field :createGroup, mutation: Mutations::CreateGroup
  field :updateGroup, mutation: Mutations::UpdateGroup
  field :deleteGroup, mutation: Mutations::DeleteGroup

  field :createClap, mutation: Mutations::CreateClap
end
