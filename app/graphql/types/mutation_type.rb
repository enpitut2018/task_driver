Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"
  
  field :startTaskMutation, Mutations::StartTaskMutation.field
  field :createClapMutation, Mutations::CreateClapMutation.field
  # TODO: Remove me
  field :testField, types.String do
    description "An example field added by the generator"
    resolve ->(obj, args, ctx) {
      "Hello World!"
    }
  end
end
