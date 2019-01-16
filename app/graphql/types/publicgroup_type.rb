class Types::PublicgroupType < Types::BaseObject
  field :groups, Types::GroupType, '日付', null: false
  field :users, Types::UserType, 'その日の終了コントリビューション', null: false

  def groups
    object[:groups]
  end

  def users
    object[:users]
  end

end