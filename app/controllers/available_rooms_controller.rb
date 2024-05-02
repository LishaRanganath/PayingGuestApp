class AvailableRoomsController < ApplicationController

    
    def create
        room_type = room_params[:room_type_id]
        room_type = RoomType.find_by(id: room_type)
        room_type_price=room_type.price
        category_type = room_params[:category_id]
        category_type = Category.find_by(id: category_type)
        category_price = category_type.price
        room_price = room_type_price + category_price
        available_room = AvailableRoom.create(room_params.merge(room_price: room_price))
        if available_room.save
            redirect_to pg_building_path(id: room_type.pg_building.id), notice: "Updated Room Availability"
        else
            redirect_to pg_building_path(id: room_type.pg_building.id), notice: "Could Not Update Room Availability"
        end
    end

    def destroy
        available_room=AvailableRoom.find_by(id: params[:id])
        building = PgBuilding.find_by(id: params[:pg_building_id])
        if available_room.destroy
            # debugger
            redirect_to pg_building_path(id: building.id), notice: "Room Was deleted"
        else
            redirect_to pg_building_path(id: building.id), notice: "Could Not Delete The Room"
        end

    end

    private

    def room_params
        params.require(:available_room).permit(:room_type_id, :category_id,:availability)
    end
end
