class Mutations::CreateGroup < GraphQL::Schema::Mutation
  graphql_name 'CreateGroupMutation'
  null false

  argument :parent_id, ID, description: '親グループID', required: false
  argument :name, String, description: '作成グループ名', required: true
  argument :importance, Integer, description: '重要度', required: true
  argument :deadline, Types::MomentToDatetimeType, description: '締め切り', required: true
  argument :publicity, Types::Boolean, description: '公開/非公開設定', required: false

  field :group, Types::GroupType, null: false
  field :errors, [String], null: false

  def resolve(parent_id:, name:, importance:, deadline:, publicity:)
    group = Group.new(:parent_id => parent_id, :name => name, :user_id => context[:current_user].id, :importance => importance, :deadline => deadline)
    group.publicity = publicity if !publicity.nil?
    if group.save
      { group: group, errors: [] }
    else
      { group: group, errors: group.errors.full_messages }
    end
  end
end