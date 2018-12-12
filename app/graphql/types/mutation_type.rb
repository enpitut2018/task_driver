class Types::MutationType < GraphQL::Schema::Object
  field :startTask, mutation: Mutations::StartTask
  field :createClap, mutation: Mutations::CreateClap
  # TODO: Remove me
  field :test_field, String, description: "An example field added by the generator", null: true

  def test_field
    "Hello World!"
  end
end
