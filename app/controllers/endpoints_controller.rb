class EndpointsController < ApplicationController
    def register
        user = User.find(current_user.id)
        user.registration_id = params[:id]
        user.save
        #ridirect_to '/tasks/index'
    end
  end