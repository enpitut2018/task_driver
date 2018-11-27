Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID
  field :email, !types.String
  field :username, types.String
  field :created_at, !Types::MomentType
  field :updated_at, !Types::MomentType
  connection :groups, !Types::GroupType.connection_type
end
