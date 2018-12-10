class Types::TaskType < Types::BaseObject
  field :id, ID, 'タスクID', null: false
  field :name, String, 'タスク名', null: false
  field :deadline, Types::MomentType, 'タスク締め切り', null: false
  field :importance, Integer, '重要度', null: false
  field :note, String, 'メモ', null: true
  field :status, Integer, '進行状態(0: TODO, 1: DOING, 2: DONE)', null: false
  field :start_time, Types::MomentType, '開始時刻', null: true
  field :finish_time, Types::MomentType, '終了時刻', null: true
  field :created_at, Types::MomentType, '作成時刻', null: false
  field :updated_at, Types::MomentType, '更新時刻', null: false
  field :user_id, ID, 'ユーザーID', null: false
  field :urgency, Integer, '緊急度', null: true
  field :priority, Integer, '優先度', null: true
  field :group_id, ID, 'グループID', null: false
  field :crap, Integer, '拍手', null: false
  field :contributions, Types::ContributionType.connection_type, 'コントリビューション', null: false, connection: true
end
