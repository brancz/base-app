class Api::ProfilesController < Api::BaseController
  # GET /api/users/me
  def me
    @user = current_user
    render json: @user
  end
end
