class Types::GroupType < Types::BaseObject
  field :id, ID, 'グループID', null: false
  field :user_id, ID, 'ユーザーID', null: false
  field :name, String, 'グループ名', null: false
  field :parent_id, ID, '親グループID', null: true
  field :created_at, Types::DatetimeToMomentType, '作成日時', null: false
  field :updated_at, Types::DatetimeToMomentType, '更新日時', null: false
  field :deadline, Types::DatetimeToMomentType, '締め切り', null: true
  field :importance, Integer, '重要度', null: true
  field :visible, Boolean, '公開/非公開', null: true
  field :tasks, [Types::TaskType], 'タスク', null: true

  def tasks
    object.tasks
  end
end
