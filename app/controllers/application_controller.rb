class ApplicationController < ActionController::API
  include ApiException::Handler
  attr_reader :current_user

  private

  def authorize!
    @current_user = User.find_by_token!(token)

  rescue ActiveRecord::RecordNotFound
    raise ApiException::Unauthorized
  end

  def set_current_user
    @current_user = User.find_by_token!(token) rescue nil
  end

  def token
    identifier, token = request.headers[:Authorization]&.split(' ')
    raise ApiException::InvalidToken if identifier.blank? || identifier != 'Bearer' || token.blank?

    token
  end
end
