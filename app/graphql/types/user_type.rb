class Types::UserType < Types::BaseObject
	field :id, ID, 'ユーザーID', null: false
	field :email, String, 'メールアドレス', null: false
	field :username, String, 'ユーザー名', null: false
	field :created_at, Types::MomentType, '作成時刻', null: true
	field :updated_at, Types::MomentType, '更新時刻', null: true
	field :groups, Types::GroupType.connection_type, '所有グループ', null: false, connection: true
	field :contributions, Types::ContributionType.connection_type, 'コントリビューション', null: false, connection: true
end