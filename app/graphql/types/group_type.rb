Types::GroupType = GraphQL::ObjectType.define do
  name "Group"
  field :id, !types.ID, 'グループID'
  field :user_id, !types.ID, 'ユーザーID'
  field :name, !types.String, 'グループ名'
  field :parent_id, types.ID, '親グループID'
  field :created_at, !Types::MomentType, '作成日時'
  field :updated_at, !Types::MomentType, '更新日時'
  field :deadline, Types::MomentType, '締め切り'
  field :importance, types.Int, '重要度'
  field :visible, types.Boolean, '公開/非公開'
  connection :tasks, Types::TaskType.connection_type, 'タスク'
end
