Types::MomentType = GraphQL::ScalarType.define do
  name 'MomentType'
  description "return string format for generating a moment object in moment.js Example: '2018-01-01 00:00:00 +0900'"

  coerce_input ->(value, ctx) {
    # input: instance of ActiveSupport::TimeWithZone
    if !value.is_a?(ActiveSupport::TimeWithZone)
      raise GraphQL::CoercionError, "#{input_value.inspect} is not a instance of TimeWithZone"
    end
  }
  coerce_result ->(value, ctx) {
    # output: 
    value.to_time.to_s
  }
end