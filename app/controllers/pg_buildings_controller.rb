# To handle all the actions of the PG Buildings
class PgBuildingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def search
    @resultant_buildings = PgBuilding.where("name LIKE ?", "%#{params[:query]}%").order("LOWER(name)")
    render partial: "home/search_results" ,locals:{resultant_buildings:@resultant_buildings}
  end
  
  def filter
    
    if params[:query] == 'asc'
      order_type = params[:query]
    else
      order_type = params[:query]
    end
    
    resultant_buildings = PgBuilding.order(name: order_type)
    @results = resultant_buildings.joins(:room_types, :categories)
                             .where("room_types.name LIKE ? OR categories.name LIKE ?", "%#{params[:room_query]}%", "%#{params[:room_query]}%")
                             .order("LOWER(room_types.name)", "LOWER(categories.name)")
    # debugger
    render partial: "home/search_results" ,locals:{results: @results}
  end
  
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
