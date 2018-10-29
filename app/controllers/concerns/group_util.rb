module GroupUtil
  extend ActiveSupport::Concern

  def get_ancestor_groups(group)
    ancestors = [group]
    current_node = group
    while current_node = Group.where(id: current_node.parent_id)[0] do
      ancestors.push(current_node)
    end
    return ancestors.reverse!
  end

  def get_descendant_groups(group)
    descendants = [group]
    stack = [group]
    while current_node = stack.pop do
      children = Group.where(parent_id: current_node.id)
      stack += children
      descendants += children
    end
    return descendants
  end
end