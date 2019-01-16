class Types::GroupType < Types::BaseObject
  field :id, ID, 'グループID', null: false
  field :user_id, ID, 'ユーザーID', null: false
  field :name, String, 'グループ名', null: false
  field :parent_id, ID, '親グループID', null: true
  field :created_at, Types::DatetimeToMomentType, '作成日時', null: false
  field :updated_at, Types::DatetimeToMomentType, '更新日時', null: false
  field :deadline, Types::DatetimeToMomentType, '締め切り', null: true
  field :importance, Integer, '重要度', null: true
  field :public, Boolean, '公開/非公開', null: false
  field :tasks, [Types::TaskType], 'タスク', null: true
  field :parent_group, Types::GroupType, '親グループ', null: true
  field :ancestor_groups, [Types::GroupType], '先祖グループ', null: true
  field :ancestor_and_self_groups, [Types::GroupType], '自分と先祖グループ', null: true

  def tasks
    object.tasks
  end

  def parent_group
    Group.find(object.parent_id) if !object.parent_id.nil?
  end

  def ancestor_groups
    tmp_parent = Group.find(parent_id) if !object.parent_id.nil?
    ancestor_groups = []
    while !tmp_parent.nil?
      ancestor_groups.push(tmp_parent)
      if !tmp_parent.parent_id.nil?
        tmp_parent = Group.find(tmp_parent.parent_id)
      else
        tmp_parent = nil
      end
    end
    ancestor_groups
  end

  def ancestor_and_self_groups
    ancestor_and_self_groups = [Group.find(object.id)]
    ancestor_and_self_groups.push(ancestor_groups).flatten!
  end
end
