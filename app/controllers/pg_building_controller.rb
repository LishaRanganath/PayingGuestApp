# To handle all the actions of the PG Buildings
class PgBuildingController < ApplicationController

  # To display all the PGs that are owned by the Owner
  def show
    @owner=Owner.find_by(id: params[:id])
    @pg_buildings=@owner.pg_buildings
  end

  #To create a new instance of PgBuilding
  def new
    @pg_building = PgBuilding.new
  end

  #To create the new PG Building
  def create
    @owner_id = params[:id] 
    new_building = @owner.pg_buildings.create(building_params)
    if new_building.save
      redirect_to root_path, notice: "Building added sucessfully"
    else
      render :new, notice: "Building could not be added "
    end
  end


  private

  def building_params
    params.require(:pg_building).permit(:name,:phone,:address,:email,:image)
  end
end
