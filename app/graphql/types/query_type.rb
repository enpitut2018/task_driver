Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :me, !Types::UserType do
    resolve -> (_obj, args, ctx) {
      User.find(ctx[:current_user].id)
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

  field :contribution, !Types::ContributionType do
    resolve -> (_obj, args, ctx) {
    }
  end

  field :task, !Types::TaskType do
    argument :id, types.ID
    resolve ->(obj, args, ctx) {
      Task.find(args['id'])
    }
  end

end
