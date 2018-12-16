class Types::MutationType < GraphQL::Schema::Object
  field :createTask, mutation: Mutations::CreateTaskMutation
  field :startContribution, mutation: Mutations::StartContribution
  field :finishContribution, mutation: Mutations::FinishContribution
  field :createClap, mutation: Mutations::CreateClap
  
  # TODO: Remove me
  field :test_field, String, description: "An example field added by the generator", null: true

  def test_field
    "Hello World!"
  end
end
