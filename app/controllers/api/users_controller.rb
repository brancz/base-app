class Api::UsersController < Api::BaseController
  before_action :set_paste, only: [:show, :edit, :destroy]

  # GET /api/users/myself
  def myself
    @user = current_user
    render json: @user
  end

  # GET /api/users.json
  def index
    authorize! :index, User
    @users = Users.all
  end

  # GET /api/users/1.json
  def show
    authorize! :read, @user
  end

  # PUT/PATCH /api/users/1.json
  def update
    authorize! :update, @user
    if @paste.update(user_params)
      format.json { head :no_content }
    else
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /api/users/1.json
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
