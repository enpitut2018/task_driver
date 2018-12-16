class Types::MomentToDatetimeType < Types::BaseScalar
  graphql_name 'MomentToDatetimeType'

  def self.coerce_input(value, ctx)
    if !DateTime.parse(value).is_a?(DateTime)
      raise GraphQL::CoercionError, "#{input_value.inspect} cannot be parsed into DateTime"
    end
  end
  def self.coerce_result(value, ctx)
    DateTime.parse(value)
  end
end