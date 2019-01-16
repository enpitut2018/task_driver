class Mutations::ForkGroup < GraphQL::Schema::Mutation
  graphql_name 'ForkGroupMutation'
  null false

  argument :group_id, ID, description: 'グループID', required: true

  field :groups, [Types::GroupType], null: false
  field :errors, [String], null: false

  def resolve(group_id:)
    new_groups = []
    group = Group.find(group_id)
    new_parent_id, new_group = fork(group, nil)
    new_groups.push(new_group)
    new_groups.push(search(group_id, new_parent_id))

    return { groups: new_groups.flatten(), errors: [] }
  end

  def search(parent_id, new_parent_id)
    new_groups = []
    while true do
      groups = Group.where(parent_id: parent_id)
      if groups.empty?
        break
      else
        groups.each do |group|
          new_group_id, new_group = fork(group, new_parent_id)
          new_groups.push(new_group)
          new_groups.push(search(group.id, new_group_id))
        end
        break
      end
    end
    return new_groups
  end
  
  def fork(group, new_parent_id)
    group_attribute = group.attributes
    group_attribute.delete('id')
    group_attribute.delete('created_at')
    group_attribute.delete('updated_at')

    new_group = Group.new(group_attribute.merge({:user_id => context[:current_user].id, :parent_id => new_parent_id, :public => false}))
    new_group.save

    tasks = Task.where(group_id: group.id)

    tasks.each do |task|
      task_attribute = task.attributes
      task_attribute.delete('id')
      task_attribute.delete('created_at')
      task_attribute.delete('updated_at')

      task = Task.new(task_attribute.merge({:user_id => context[:current_user].id, :group_id => new_group.id}))
      task.save
    end

    return new_group.id, new_group
  end
end