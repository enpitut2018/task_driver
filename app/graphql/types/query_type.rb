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

  field :groups, [Types::GroupType], null: true do
    description '全てのグループの情報を返す'
  end

  field :task, Types::TaskType, null: true do
    description '指定したIDを持つタスクの情報を返す'
    argument :id, ID, 'タスクID', required: true
  end

  field :contribution, Types::ContributionType, null: true do
    description '指定したIDを持つコントリビューションの情報を返す'
    argument :id, ID, 'コントリビューションID', required: true
  end

  def me
    User.find(context[:current_user].id)
  end

  def user(id:)
    User.find(id)
  end

  def group(id:)
    group = Group.find(id)
    if group[:public]
      # 公開グループの場合の処理
      group
    elsif context[:current_user].nil?
      # GraphiQLでエラーを出さないための処理
      nil
    elsif context[:current_user].id == group[:user_id]
      # 所有ユーザーの場合の処理
      group
    else
      # 所有ユーザーでない場合の処理
      nil
    end
  end

  def task(id:)
    task = Task.find(id)
    group = Group.find(task.group_id)
    if group[:public]
      # 公開グループのタスクの場合
      task
    elsif context[:current_user].nil?
      # GraphiQLでエラーを出さないための処理
      nil
    elsif context[:current_user].id == group[:user_id]
      # 所有ユーザーの場合の処理
      task
    else
      # 所有ユーザーでない場合の処理
      nil
    end
  end

  def contribution(id:)
    Contribution.find(id)
  end
end
