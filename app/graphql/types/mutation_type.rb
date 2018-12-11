class Types::MutationType < Types::BaseObject
  field :start_task_mutation, Mutations::StartTask
  field :create_clap_mutation, Mutations::CreateClap
  # TODO: Remove me
  field :test_field, String, description: "An example field added by the generator", null: true

  def test_field
    "Hello World!"
  end
end
