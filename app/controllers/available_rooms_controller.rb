class AvailableRoomsController < ApplicationController

    def calculate_price
        room_type = room_params[:room_type_id]
        room_type = RoomType.find_by(id: room_type)
        room_type_price=room_type.price
        category_type = room_params[:category_id]
        category_type = Category.find_by(id: category_type)
        category_price = category_type.price
        @room_price = room_type_price + category_price
        puts("==========================================")
        puts @room_price
        @room_price
    end

    private

    def room_params
        params.require(:available_room).permit(:room_type_id, :category_id)
    end
end
