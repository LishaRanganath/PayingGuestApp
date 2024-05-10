class OwnersController < ApplicationController
  before_action :check_if_admin
  def index
    @owner_all = Owner.all
    @deactive_owners = Owner.where(status: "deactive")
    @active_owners = Owner.where(status: "active")
  end
  def new
    @owner = Owner.new
    @owner.build_user
  end


  def create
    owner = OwnersManager::OwnerCreator.new(owner_params, admin_id: current_user.admin.id).create
    if owner
      redirect_to root_path, notice: "Owner and user successfully created."
    else
      flash.now[:alert] = @owner.errors.full_messages.join(", ")
    end
  end

  def edit
    @owner = get_owner(id: params[:id])
  end

  def update
    @owner = Owner.find(params[:id])
    if @owner.update(owner_params)
      puts"=================================="
      flash[:success] = "Owner updated successfully"
      redirect_to owners_path
    end
  end

  def destroy
    owner = get_owner(params[:id])
    user_as_owner = User.find_by(id: owner.user.id)
    if owner.destroy && user_as_owner.destroy
      redirect_to root_path, notice: "Owner deleted sucessfully"
    else
      redirect_to root_path, alert: "Owner was not deleted"
    end
  end

  def activate
    @owner_activate = get_owner(id: params[:id])
    @owner_activate.update(status: "active")
    if @owner_activate.save
      redirect_to owners_path , notice: "Status sucessfully updated"
    else
      redirect_to owners_path , notice: "Status was not updated"
    end
  end

  def deactivate
    @owner_deactivate = get_owner(id: params[:id])
    @owner_deactivate.update(status: @owner_deactivate.status="deactive")
    if @owner_deactivate.save
      redirect_to owners_path , notice: "Status sucessfully updated"
    else
      redirect_to owners_path , alert: "Status was not updated"
    end
  end

  private

  def check_if_admin
    if current_user.role == "admin"
       puts "you are admin"
    end
  end

  def get_owner(owner_id)
    owner = Owner.find_by(id: owner_id)
    owner
  end

  def owner_params
    params.require(:owner).permit(:name, :phone,:admin_id, user_attributes: [:email, :password,:role])
  end
end
