Types::TaskType = GraphQL::ObjectType.define do
  name "Task"
  field :id, !types.ID
  field :name, !types.String
  field :deadline, !types.String
  field :importance, !types.Int
  field :note, types.String
  field :status, !types.Int
  field :start_time, types.String
  field :finish_time, types.String
  field :created_at, !types.String
  field :updated_at, !types.String
  field :user_id, !types.ID
  field :urgency, types.Int
  field :priority, types.Int
  field :group_id, !types.ID
end
