class EndpointsController < ApplicationController
    def register
      user = User.find_by(id: current_user.id)
      user.endpoint = params[:endpoint]
      user.key = params[:publicKey]
      user.auth = params[:auth]
      user.encoding = params[:contentEncoding]
      user.save
      #ridirect_to '/tasks/index'
    end

    def getVapidPublicKey
      render :json => {vapidPublicKey: ENV['VAPID_PUBLIC_KEY']}
    end
  end