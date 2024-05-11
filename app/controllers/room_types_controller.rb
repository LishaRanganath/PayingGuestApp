class RoomTypesController < ApplicationController
    def create
        
        building =PgBuilding.find_by(id: room_params[:pg_building_id])
        # debugger
        room_type = building.room_types.create(room_params)
        if room_type.save
            redirect_to pg_building_path(id: building.id), notice: "The room type was created sucessfully"
        else
            redirect_to pg_building_path(id: building.id), notice: "The room type could not be created"
        end
    end

    def destroy
        room_type=RoomType.find_by(id: params[:id])
        if room_type.destroy
            redirect_to pg_building_path(id: room_type.pg_building.id), notice: "Room Type was deleted"
        else
            redirect_to pg_building_path(id: room_type.pg_building.id), notice: "Room Type could not be deleted"
        end

    end

    def edit
        @room_type = RoomType.find_by(id: params[:id])
    end
    
    def update
        room_type=RoomType.find_by(id: params[:id])
        room_type.update(room_params)
        if room_type.save
            redirect_to pg_building_path(id: room_type.pg_building.id), notice: "Room Type Updated Sucessfully"
        else
            redirect_to pg_building_path(id: room_type.pg_building.id), notice: "Could Not Update Room Type"
        end
    end

    private

    def room_params
        params.require(:room_type).permit(:name,:price,:pg_building_id)
    end

end
