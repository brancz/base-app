class ProfilesController < ApplicationController
  before_action :authenticate_user!

  # GET /users
  def me
    @user = current_user
    render json: @user
  end
end
