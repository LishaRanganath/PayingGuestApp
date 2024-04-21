class OwnerController < ApplicationController
  # before_action :check_if_admin
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
      render :new
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
