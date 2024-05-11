# To handle all the actions of the PG Buildings
class PgBuildingsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def search
    @resultant_buildings = PgBuilding.where("name LIKE ?", "%#{params[:query]}%").order("LOWER(name)")
    render partial: "home/search_results" ,locals:{resultant_buildings:@resultant_buildings}
  end

  def filter
    # debugger
    order_type = params[:query]
    @resultant_buildings = PgBuilding.all
    if params[:query].present?
      @resultant_buildings = PgBuilding.order(name: order_type)
    end

    if params[:room_query].present?
      @resultant_buildings = @resultant_buildings.joins(:room_types).where("room_types.name LIKE ?", "%#{params[:room_query]}%")
    end

    if params[:category_query].present?
      @resultant_buildings = @resultant_buildings.joins(:categories).where("categories.name LIKE ?", "%#{params[:category_query]}%")
    end

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
