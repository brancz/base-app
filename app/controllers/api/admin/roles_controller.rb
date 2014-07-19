class Api::Admin::RolesController < Api::Admin::BaseController
  before_action :set_role, only: [:show, :update, :destroy]

  # GET /api/admin/roles.json
  def index
    authorize! :index, Role
    @roles = Role.all
    render json: @roles
  end

  # GET /api/admin/roles/1.json
  def show
    authorize! :read, @role
    render json: @role
  end
 
  # POST /api/admin/roles.json
  def create
  end

  # PUT/PATCH /api/admin/roles/1.json
  def update
    authorize! :update, @role
    if @role.update(role_params)
      format.json { head :no_content }
    else
      format.json { render json: @role.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /api/admin/roles/1.json
  def destroy
    authorize! :destroy, @role
    @role.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name, :internal_name)
  end
end
