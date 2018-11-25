Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID
  field :email, !types.String
  field :username, types.String
  field :created_at, !types.String
  field :updated_at, !types.String
  connection :groups, !Types::GroupType.connection_type
end
