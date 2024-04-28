class OwnersController < ApplicationController
  # before_action :check_if_admin
  def index
    @owner_all = Owner.all
  end
  def new
    @owner = Owner.new
    @owner.build_user
  end


  def create
    @owner = Owner.new(owner_params)
    @owner.admin_id = current_user.admin.id
    if @owner.save
      @owner.user.update(role: 'owner')
      redirect_to root_path, notice: "Owner and user successfully created."
    else
      flash.now[:alert] = @owner.errors.full_messages.join(", ")
    end
  end

  def edit
    @owner=Owner.find_by(id: params[:id])
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
    owner = Owner.find_by(id: params[:id])
    if owner.destroy
      redirect_to root_path, notice: "Owner deleted sucessfully"
    else
      redirect_to root_path, alert: "Owner was not deleted"
    end
  end

  def activate
    @owner_activate = Owner.find_by(id: params[:id])
    @owner_activate.update(status: "active")
    if @owner_activate.save
      redirect_to owners_path , notice: "Status sucessfully updated"
    else
      redirect_to owners_path , notice: "Status was not updated"
    end
  end

  def deactivate
    @owner_deactivate = Owner.find_by(id: params[:id])
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

  def owner_params
    params.require(:owner).permit(:name, :phone,:admin_id, user_attributes: [:email, :password,:role])
  end
end
