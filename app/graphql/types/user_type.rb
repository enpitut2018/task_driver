Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID, 'ユーザーID'
  field :email, !types.String, 'メールアドレス'
  field :username, types.String, 'ユーザー名'
  field :created_at, !Types::MomentType, '作成時刻'
  field :updated_at, !Types::MomentType, '更新時刻'
  connection :groups, !Types::GroupType.connection_type, '所有グループ'
end
