class Types::ContributionType < Types::BaseObject
  field :id, ID, 'コントリビューションID', null: false
  field :user_id, ID, 'ユーザーID', null: false
  field :task_id, ID, 'タスクID', null: false
  field :created_at, Types::MomentType, '開始時刻', null: false
  field :finish_time, Types::MomentType, '終了時刻', null: true
  field :is_finish?, types.Boolean, 'このコントリビューションでタスクを終了したか否か'
end