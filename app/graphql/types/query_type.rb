Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :user, !Types::UserType do
    resolve -> (_obj, args, ctx) {
      ctx[:current_user]
    }
  end

  field :group, !Types::GroupType do
    resolve -> (_obj, args, ctx) {
    }
  end

  field :task, !Types::TaskType do
    resolve -> (_obj, args, ctx) {
    }
  end
end
