class AuthController < ApplicationController
  before_action :authorize!, only: :sign_out

  def check_available_email
    render json: { available: !User.exists?(email: params[:email]) }
  end

  def sign_up
    @user = User.create!(sign_up_params)
  end

  def sign_in
    @user = User.find_by_email!(params[:email])
               .authenticate!(params[:password])
               .generate_tokens!

  rescue ActiveRecord::RecordNotFound
    raise ApiException::Unauthorized
  end

  def sign_out
    @current_user.invalidate_token!

    head :no_content
  end

  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation, :nickname)
  end
end
