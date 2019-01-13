# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end
  
  #POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected
  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end

  def confirm
    account = User.find_by_confirmation_token(post_params[:confirmation_token])
    
    if account.confirmed_at.empty?
      account = User.confirm_by_token(account.confirmation_token)
      account.update(username: post_params[:username])
    
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
    params.require(:confirmation).permit(
      :confirmation_token, :username
    )
  end
end
