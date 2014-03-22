class Api::SessionsController < Api::BaseController
	skip_before_filter :verify_authenticity_token
	skip_before_filter :token_authenticate_user!, only: :create
	skip_before_filter :authenticate_user!, only: [:create, :heartbeat]

  def heartbeat
    render json: {session_alive: user_signed_in?}
  end

  def create
    if params[:user_email] && params[:user_password]
      user_email = params[:user_email].presence
      user = user_email && User.find_by_email(user_email)

      if user && user.valid_password?(params[:user_password])
        token = AuthenticationToken.new
        token.user = user
        sign_in user, store: false
        render json: {user_token: token.token}, status: :created
      else
        invalid_authentication
      end
    else
      unauthenticated
    end
  end

  def destroy
    sign_out(current_session_token.user)
    current_session_token.delete!
    render nothing: true, status: :no_content
  end
end
