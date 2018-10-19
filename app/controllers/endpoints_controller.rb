class EndpointsController < ApplicationController
    def register
      task = User.find_by(id: current_user.id)
      user.endpoint = params[:id]
      user.save
      #ridirect_to '/tasks/index'
    end
  end