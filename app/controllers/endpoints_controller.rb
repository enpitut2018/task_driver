class EndpointsController < ApplicationController
    #protect_form_forgeryでCSRF対策(外部からのPOSTを弾く)の例外を設定
    protect_from_forgery :except => [:register]

    def register
      user = User.find_by(id: current_user.id)
      user.endpoint = params[:endpoint]
      user.key = params[:publicKey]
      user.auth = params[:auth]
      user.encoding = params[:contentEncoding]
      user.save
      ridirect_to '/tasks/index'
    end

    def getVapidPublicKey
      render :json => {vapidPublicKey: ENV['VAPID_PUBLIC_KEY']}
    end
  end