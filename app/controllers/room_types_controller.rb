class RoomTypesController < ApplicationController
    def create
        building =PgBuilding.find_by(params[:id])
        room_type = building.room_types.create(room_params)
        if room_type.save
            redirect_to root_path, notice: "The room type was created sucessfully"
        else
            redirect_to root_path, notice: "The room type could not be created"
        end
    end


    private

    def room_params
        params.require(:room_type).permit(:name,:price)
    end

end
