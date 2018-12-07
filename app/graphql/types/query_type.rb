Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :me, !Types::UserType do
    resolve -> (_obj, args, ctx) {
      User.find(ctx[:current_user_id])
    }
  end

  field :user, !Types::UserType do
    resolve -> (_obj, args, ctx) {
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
