class RegistrationsController < Devise::RegistrationsController

  # GET /api/users/me
  def me
    @user = current_user
    if @user
      render json: @user
    else
      render json: {error: t("devise.failure.unauthenticated")}, status: :unauthorized
    end
  end

end
