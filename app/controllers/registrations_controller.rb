class RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :token_authenticate_user!

  # GET /api/users/myself
  def myself
    @user = current_user
    render json: @user
  end

end
