# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  respond_to :json

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /v1/sign_up
  def create
    user = User.new(post_params)

    if user.save
      render :json => user.as_json(:success => 'success', :email => user.email), :status => 201
    else
      warden.custome_failure!
      render :json => user.errors, :status => 422
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    super
    @tasks = Task.where(user_id: @user.id)
    @tasks.each do |task|
      task.destroy
    end

    @groups = Group.where(user_id: @user.id)
    @groups.each do |group|
      group.destroy
    end
  end

  private
  def post_params
    # モデル作成に必要な引数を指定
    params.require(:user).permit(
      :email, :password, :password_confirmation, :username
      )
end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  
  def edit
  end
end
