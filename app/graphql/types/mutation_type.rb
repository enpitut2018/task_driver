class Types::MutationType < GraphQL::Schema::Object
  field :startContribution, mutation: Mutations::StartContribution
  field :finishContribution, mutation: Mutations::FinishContribution
  field :createClap, mutation: Mutations::CreateClap
  field :createTask, mutation: Mutations::CreateTask
end
