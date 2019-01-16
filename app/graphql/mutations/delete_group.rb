class Mutations::DeleteGroup < GraphQL::Schema::Mutation
  graphql_name 'DeleteGroupMutation'
  null false

  argument :group_id, ID, description: 'グループID', required: true

  field :group, Types::GroupType, null: false
  field :errors, [String], null: false

  def resolve(group_id:)
    group = Group.find(group_id)
    if group.user_id != cotext[:current_user].id
      return { group: group, errors: ['specified group is not yours.'] }
    end

    if group.destroy
      { group: group, errors: [] }
    else
      { group: group, errors: group.errors.full_messages }
    end
  end
end