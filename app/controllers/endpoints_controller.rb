class EndpointsController < ApplicationController
    def register
      task = User.find_by(id: current_user.id)
    end
  end