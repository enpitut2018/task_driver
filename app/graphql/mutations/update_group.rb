class Mutations::UpdateGroup < GraphQL::Schema::Mutation
  graphql_name 'UpdateGroupMutation'
  null false

  argument :group_id, ID, description: 'グループID', required: true
  argument :parent_id, ID, description: '親グループID', required: false
  argument :name, String, description: '作成グループ名', required: false
  argument :importance, Integer, description: '重要度', required: false
  argument :deadline, Types::MomentToDatetimeType, description: '締め切り', required: false
  argument :publicity, Boolean, description: '公開/非公開設定', required: false

  field :group, Types::GroupType, null: false
  field :errors, [String], null: false

  def resolve(group_id:, parent_id:, name:, importance:, deadline:, publicity:)
    group = Group.find(group_id)
    if group.user_id != context[:current_user].ID
      return { group: group, errors: ['specified group is not yours.'] }
    end

    group.parent_id = parent_id if !parent_id.nil?
    group.name = name if !name.nil?
    group.importance = importance if !importance.nil?
    group.deadline = deadline if !deadline.nil?
    group.publicity = publicity if !publicity.nil?
    
    if group.save
      { group: group, errors: [] }
    else
      { group: group, errors: group.errors.full_messages }
    end
  end
end