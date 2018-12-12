class GraphqlController < ApplicationController
  protect_from_forgery except: :execute

  # GraphiQLからの認証なしでのアクセスを許可
  # GraphiQLはdevelopment環境のみでマウントされる
  before_action :authenticate_user!, :if => :not_graphiql?

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      current_user: current_user
    }
    result = MyappSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def not_graphiql?
    request.headers[:referer] != 'http://localhost:3001/graphiql'
  end
end
