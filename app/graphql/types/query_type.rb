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
end
