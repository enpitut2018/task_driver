class Types::QueryType < Types::BaseObject
  graphql_name "Query"

  field :me, Types::UserType, null: true do
    description 'ログインユーザーの情報を返す'
  end

  field :user, Types::UserType, null: true do
    description '指定したIDを持つユーザーの情報を返す'
    argument :id, ID, 'ユーザーID', required: true
  end

  field :group, Types::GroupType, null: true do
    description '指定したIDを持つグループの情報を返す'
    argument :id, ID, 'グループID', required: true
  end

  field :task, Types::TaskType, null: true do
    description '指定したIDを持つタスクの情報を返す'
    argument :id, ID, 'タスクID', required: true
  end

  field :contribution, Types::ContributionType, null: true do
    description '指定したIDを持つコントリビューションの情報を返す'
    argument :id, ID, 'コントリビューションID', required: true
  end

  field :activities, [Types::ActivityType], null: true do
    description '指定したIDを持つユーザーのを日付ごとにまとめた終了タスクと終了コントリビューションを配列として返す'
    argument :user_id, ID, 'ユーザーID', required: true
  end

  def me
    User.find(context[:current_user].id)
  end

  def user(id:)
    User.find(id)
  end

  def group(id:)
    Group.find(id)
  end

  def task(id:)
    Task.find(id)
  end

  def contribution(id:)
    Contribution.find(id)
  end

  def activities(user_id:)
    # 指定したユーザーのコントリビューションとタスクをそれぞれ終了日毎にグループ化してhashを生成
    # {"20180101" => [#<Contribution>, ...], "20180102" =>[], ...}
    grouped_contributions = Contribution.finished.where(user_id: user_id).group_by{|c| c.finished_at.strftime('%Y%m%d')}
    grouped_tasks = Task.finished.where(user_id: user_id).group_by{|t| t.finish_time.strftime('%Y%m%d')}

    # hashの配列に変換
    # [{ :date => "20180101", :contributions => [#<Contribution>, ...], :tasks => [#<Task>, ...] }, ...]
    grouped_contributions.map{ |idx, val|
      grouped_tasks[:idx].nil? ? { :date => idx, :contributions => val, :tasks => [] } : { :date => idx, :contributions => val, :tasks => grouped_tasks[:idx] }
    }
  end
end
