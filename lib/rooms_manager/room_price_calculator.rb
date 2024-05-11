module RoomsManager
    class RoomPriceCalculator
        def self.calculate_price(room_type_id, category_id)
            room_type = RoomType.find_by(id: room_type_id)
            room_type_price = room_type.price
            category_type = Category.find_by(id: category_id)
            category_price = category_type.price
            room_type_price + category_price
        end
    end
end