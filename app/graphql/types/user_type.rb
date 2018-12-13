class Types::UserType < Types::BaseObject
	field :id, ID, 'ユーザーID', null: false
	field :email, String, 'メールアドレス', null: false
	field :username, String, 'ユーザー名', null: false
	field :created_at, Types::MomentType, '作成時刻', null: true
	field :updated_at, Types::MomentType, '更新時刻', null: true
	field :groups, [Types::GroupType], '所有グループ', null: true
	field :tasks, [Types::TaskType], '所有タスク', null: true
	field :contributions, [Types::ContributionType], 'コントリビューション', null: true

	def groups
		object.groups
	end 

	def tasks
		object.tasks
	end

	def contributions
		object.contributions
	end
end