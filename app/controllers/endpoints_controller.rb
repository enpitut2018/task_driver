class EndpointsController < ApplicationController
    def register
      user = User.find_by(id: current_user.id)
      user.endpoint = params[:id]
      user.save
      #ridirect_to '/tasks/index'
    end
  end