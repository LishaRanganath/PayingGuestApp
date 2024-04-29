# To handle all the actions of the PG Buildings
class PgBuildingsController < ApplicationController
  def list
    owner=Owner.find_by(id: params[:id])
    @owner_buildings=owner.pg_buildings
  end

  # To display all the PGs that are owned by the Owner
  def show
    if current_user && current_user.owner?
      owner=Owner.find_by(id: current_user.owner.id)
      @pg_buildings=owner.pg_buildings
    end
    @pg_building=PgBuilding.find_by(id: params[:id])
  end

  #To create a new instance of PgBuilding
  def new
    @pg_building = PgBuilding.new
  end

  #To create the new PG Building
  def create
    @current_owner = current_user.owner
    @name=building_params[:name]
    # puts ("=======================================")
    puts @name
    new_building = @current_owner.pg_buildings.create(building_params)
    if new_building.save
      redirect_to root_path, notice: "Building added sucessfully"
    else
      render :new, notice: "Building could not be added "
    end
  end

  #To destroy the PG Building
  def destroy
    # puts("=========================================================")
    building=PgBuilding.find_by(id: params[:id])
    if building.destroy
      redirect_to root_path, notice: "Building deleted"
    else
      redirect_to root_path, notice: "Building cannot be deleted"
    end
  end


  private

  def building_params
    params.require(:pg_building).permit(:name,:phone,:address,:email,:image)
  end
end
