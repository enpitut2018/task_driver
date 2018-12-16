class Types::TaskType < Types::BaseObject
  field :id, ID, 'タスクID', null: false
  field :name, String, 'タスク名', null: false
  field :deadline, Types::DatetimeToMomentType, 'タスク締め切り', null: false
  field :importance, Integer, '重要度', null: false
  field :note, String, 'メモ', null: true
  field :status, Integer, '進行状態(1: TODO, 2: DOING, 3: DONE)', null: false
  field :start_time, Types::DatetimeToMomentType, '開始時刻', null: true
  field :finish_time, Types::DatetimeToMomentType, '終了時刻', null: true
  field :created_at, Types::DatetimeToMomentType, '作成時刻', null: false
  field :updated_at, Types::DatetimeToMomentType, '更新時刻', null: false
  field :user_id, ID, 'ユーザーID', null: false
  field :urgency, Integer, '緊急度', null: true
  field :priority, Integer, '優先度', null: true
  field :group_id, ID, 'グループID', null: false
  field :clap, Integer, '拍手', null: false
  field :contributions, [Types::ContributionType], null: true
  
  def contriubtions
    description 'コントリビューション'
    object.contributions
  end

  def status
    Task.statuses[object.status]
  end
end
