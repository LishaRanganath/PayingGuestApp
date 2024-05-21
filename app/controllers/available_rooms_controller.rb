class AvailableRoomsController < ApplicationController
    def create
        room_price = RoomsManager::RoomPriceCalculator.calculate_price(room_params[:room_type_id], room_params[:category_id])
        room= AvailableRoom.new(room_params.merge(room_price: room_price , pg_building_id: room_params[:pg_building_id]))
        # debugger
        if room.save
            redirect_to pg_building_path(id: room.pg_building.id), notice: "Updated Room Availability"
        else
            redirect_to pg_building_path(id: room.pg_building.id), notice: "Could Not Update Room Availability"
        end
    end

    def edit
        @room = AvailableRoom.find_by(id: params[:id])
    end

    def update
        room = AvailableRoom.find(params[:id])
        if room.update(room_params)
        redirect_to root_path, notice: "Room updated sucessfully"
        else
        redirect_to root_path, notice: "Could not update Room, Try Again!!"
        end
    end

    def destroy
        available_room=AvailableRoom.find_by(id: params[:id])
        building = PgBuilding.find_by(id: available_room.pg_building.id)
        if available_room.destroy
            # debugger
            redirect_to pg_building_path(id: building.id), notice: "Room Was deleted"
        else
            redirect_to pg_building_path(id: building.id), notice: "Could Not Delete The Room"
        end

    end

    private

    def room_params
        params.require(:available_room).permit(:room_type_id, :category_id,:availability,:pg_building_id)
    end
end
