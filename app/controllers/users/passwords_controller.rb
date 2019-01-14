# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
  def reset
    account = User.with_reset_password_token(post_params[:reset_password_token])

    if account.reset_password_period_valid?
      account.update(username: post_params[:username])
      account.reset_password(post_params[:password], post_params[:password])
      
      if account.present?
        render :json => account.as_json(:success => 'success', :email => account.email), :status => 201
      else
        render :json => account.errors, :status => 422
      end
    end

  end

  private
  def post_params
    # モデル作成に必要な引数を指定
    params.require(:user).permit(
      :reset_password_token, :password
    )
  end
end
