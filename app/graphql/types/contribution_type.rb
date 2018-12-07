Types::ContributionType = GraphQL::ObjectType.define do
  name "Contribution"

  field :id, !types.ID, 'コントリビューションID'
  field :user_id, !types.ID, 'ユーザーID'
  field :task_id, !types.ID, 'タスクID'
  field :created_at, !Types::MomentType, '開始時刻'
  field :finish_time, Types::MomentType, '終了時刻'
  field :is_finish?, types.Boolean, 'このコントリビューションでタスクを終了したか否か'
  
end
