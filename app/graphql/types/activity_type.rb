class Types::ActivityType < Types::BaseObject
  field :date, Types::DatetimeToMomentType, '日付', null: false
  field :contributions, [Types::ContributionType], 'その日の終了コントリビューション', null: true
  field :tasks, [Types::TaskType], 'その日の終了タスク',null: true

  def date
    object[:date]
  end

  def contributions
    object[:contributions]
  end

  def finished_tasks
    object[:tasks]
  end
end