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
    owner = Owner.new(owner_params)
    debugger
    if owner.save
      debugger
      owner.user.update(role: 'owner')
      redirect_to root_path, notice: "Owner Successfully Added."
    else
      redirect_to root_path, notice: "Could not add Owner"
    end
  end

  def edit
    @owner = get_owner(params[:id])
    # debugger
  end

  def update
    @owner = Owner.find(params[:id])
    # debugger
    if @owner.update(update_owner_params)
      redirect_to root_path, notice: "Owner updated sucessfully"
    else
      redirect_to root_path, notice: "Could not update Onwer, Try Again!!"
    end
    # debugger
  end

  def destroy
    debugger
    owner = get_owner(params[:id])
    user_as_owner = User.find_by(id: owner.user.id)
    if owner.destroy && user_as_owner.destroy
      redirect_to root_path, notice: "Owner deleted sucessfully"
    else
      redirect_to root_path, alert: "Owner was not deleted, Try Again!!"
    end
  end

  def activate
    activate_owner = get_owner(params[:id]).update(status: "active")
    if activate_owner
      redirect_to owners_path , notice: "Status sucessfully updated"
    else
      redirect_to owners_path , notice: "Status was not updated"
    end
  end

  def deactivate
    deactivate_owner = get_owner(params[:id]).update(status: "deactive")
    if deactivate_owner
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

  def update_owner_params
    params.require(:owner).permit(:name, :phone,:admin_id)
  end
  def owner_params
    params.require(:owner).permit(:name, :phone,:admin_id, user_attributes: [:email, :password,:role])
  end
end
