class Api::Admin::UsersController < Api::Admin::BaseController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /api/admin/users.json
  def index
    authorize! :index, User
    @users = Users.all
  end

  # GET /api/admin/users/1.json
  def show
    authorize! :read, @user
  end

  # PUT/PATCH /api/admin/users/1.json
  def update
    authorize! :update, @user
    if @paste.update(user_params)
      format.json { head :no_content }
    else
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /api/admin/users/1.json
  def destroy
    authorize! :destroy, @user
    @user.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
