Types::GroupType = GraphQL::ObjectType.define do
  name "Group"
  field :id, !types.ID
  field :user_id, !types.ID
  field :name, !types.String
  field :parent_id, types.ID
  field :created_at, !types.String
  field :updated_at, !types.String
  field :deadline, types.String
  field :importance, types.Int
  field :visible, types.Boolean
  connection :tasks, Types::TaskType.connection_type
end
