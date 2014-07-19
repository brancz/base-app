class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :token_authenticate_user!

  private

  def permission_denied
    render json: {error: t("devise.failure.invalid")}, status: :unauthorized
  end

  def invalid_authentication
    render json: {error: t("devise.failure.invalid")}, status: :unauthorized
  end

  def unauthenticated
    render json: {error: t("devise.failure.unauthenticated")}, status: :unauthorized
  end

  def token_authenticate_user!
    if authorization_header && current_session_token.user && current_session_token.valid?
      sign_in current_session_token.user, store: false
    end
  end

  def current_session_token
    @current_session_token ||= AuthenticationToken.new(authorization_header)
  end

  def authorization_header
    request.headers['HTTP_AUTHORIZATION']
  end

  def after_sign_in_path_for(user)
    "#/"
  end
end
