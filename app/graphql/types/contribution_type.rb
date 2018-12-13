class Types::ContributionType < Types::BaseObject
  field :id, ID, 'コントリビューションID', null: false
  field :user_id, ID, 'ユーザーID', null: false
  field :task_id, ID, 'タスクID', null: false
  field :created_at, Types::MomentType, '開始時刻', null: false
  field :finished_at, Types::MomentType, '終了時刻', null: true
  field :status, Boolean, null: false
  field :finality, Boolean, 'このコントリビューションでタスクを終了したか否か', null: false

  def status
  	Contribution.statuses[object.status]
  end

  def finality
  	Contribution.finality[object.finality]
  end
end