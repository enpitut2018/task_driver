class Types::ContributionType < Types::BaseObject
  field :id, ID, 'コントリビューションID', null: false
  field :user_id, ID, 'ユーザーID', null: false
  field :task_id, ID, 'タスクID', null: false
  field :created_at, Types::MomentType, '開始時刻', null: false
  field :finished_at, Types::MomentType, '終了時刻', null: true
  field :status, Boolean, 'コントリビューションの状態(true: active, false: inactive)', null: false
  field :finality, Boolean, 'このコントリビューションでタスクを終了したか否か(true: final, false: not_final)', null: false

  def status
  	Contribution.statuses[object.status]
  end

  def finality
  	Contribution.finalities[object.finality]
  end
end