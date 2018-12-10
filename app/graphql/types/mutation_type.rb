class Types::MutationType < Types::BaseObject
  field :start_task_mutation, Mutations::StartTaskMutation.field, null: true
  field :create_crap_mutation, Mutations::CreateCrapMutation.field, null: true
  # TODO: Remove me
  field :test_field, String, description: "An example field added by the generator", null: true

  def test_field
    "Hello World!"
  end
end
