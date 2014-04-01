class RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :token_authenticate_user!

  # GET /api/users/me
  def me
    render json: current_user
  end

end
