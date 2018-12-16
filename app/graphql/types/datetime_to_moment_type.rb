class Types::DatetimeToMomentType < Types::BaseScalar
  graphql_name 'DatetimeToMomentType'
  description "return string format for generating a moment object in moment.js Example: '2018-01-01 00:00:00 +0900'"

  def self.coerce_input(value, ctx)
    if !value.is_a?(ActiveSupport::TimeWithZone)
      raise GraphQL::CoercionError, "#{input_value.inspect} is not a instance of TimeWithZone"
    end
  end
  
  def self.coerce_result(value, ctx)
    value.to_time.to_s
  end
end