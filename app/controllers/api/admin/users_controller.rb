class Api::Admin::UsersController < Api::Admin::BaseController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /api/admin/users.json
  def index
    authorize! :index, User
    page = 1
    page = params[:page]
    @users = User.page(page)
    render json: {meta:{total: User.all.count}, users: serialized_users(@users)}
  end

  # GET /api/admin/users/1.json
  def show
    authorize! :read, @user
    render json: @user
  end

  # PUT/PATCH /api/admin/users/1.json
  def update
    authorize! :update, @user
    puts user_params
    if @user.update(user_params)
      render json: {}
    else
      render json: @user.errors, status: :unprocessable_entity
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

  def serialized_users(users)
    ActiveModel::ArraySerializer.new(users).as_json
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
