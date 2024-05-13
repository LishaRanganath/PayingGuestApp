# To handle all the actions of the PG Buildings
class PgBuildingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :check_if_owner, only:[:create,:update,:destroy]
  #To search a specific Pg building
  def search
    @resultant_buildings = PgBuildingManager::PgBuildingService.new(params[:query]).search_buildings
    render partial: "home/search_results" ,locals:{resultant_buildings:@resultant_buildings}
  end

  # to filter all the PG Buildings based on Room type/category/ascending/descending
  def filter
    filter_service = PgBuildingManager::PgBuildingService.new(params)
    @resultant_buildings = filter_service.filter_buildings

    render partial: "home/search_results" ,locals:{resultant_buildings: @resultant_buildings}
  end



  # To display all the PGs that are owned by the Owner
  def show
    @pg_building=PgBuilding.find_by(id: params[:id])
  end

  #To create a new instance of PgBuilding
  def new
    @pg_building = PgBuilding.new
  end

  #To create the new PG Building
  def create
    
    @name=building_params[:name]
    new_building = current_user.owner.pg_buildings.create(building_params).save
    if new_building
      redirect_to root_path, notice: "Building added sucessfully"
    else
      render :new, notice: "Building could not be added "
    end
  end

  #To destroy the PG Building
  def destroy
    building=PgBuilding.find_by(id: params[:id]).destroy
    if building
      redirect_to root_path, notice: "Building deleted"
    else
      redirect_to root_path, notice: "Building cannot be deleted"
    end
  end




  private

  def building_params
    params.require(:pg_building).permit(:name,:phone,:address,:email,:image)
  end

  # def check_if_owner
  #   if current_user.role == "owner"
  #     puts "you are owner"
  #    #  returns true
  #   end
  # end
end
