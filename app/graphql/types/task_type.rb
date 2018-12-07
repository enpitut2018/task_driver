Types::TaskType = GraphQL::ObjectType.define do
  name "Task"

  field :id, !types.ID, 'タスクID'
  field :name, !types.String, 'タスク名'
  field :deadline, !Types::MomentType, 'タスク締め切り'
  field :importance, !types.Int, '重要度'
  field :note, types.String, 'メモ'
  field :status, !types.Int, '進行状態(0: TODO, 1: DOING, 2: DONE)'
  field :start_time, Types::MomentType, '開始時刻'
  field :finish_time, Types::MomentType, '終了時刻'
  field :created_at, !Types::MomentType, '作成時刻'
  field :updated_at, !Types::MomentType, '更新時刻'
  field :user_id, !types.ID, 'ユーザーID'
  field :urgency, types.Int, '緊急度'
  field :priority, types.Int, '優先度'
  field :group_id, !types.ID, 'グループID'
  field :crap, !types.Int, '拍手'
end
