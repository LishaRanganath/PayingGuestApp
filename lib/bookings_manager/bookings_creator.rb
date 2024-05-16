module BookingsManager
    class BookingsCreator
        def initialize(current_user, booking_params)
            @current_user = current_user
            @booking_params = booking_params
          end
        
          def create_booking
            # debugger
            return { success: false, error_message: "User not logged in" } unless @current_user && @current_user.role == "user"
        
            room = AvailableRoom.find_by(id: @booking_params[:available_room_id])
            return { success: false, error_message: "Room not found or unavailable" } unless room.present? && room.availability >= @booking_params[:number_of_rooms].to_i
        
            price = calculate_total_price(room, @booking_params[:duration_id], @booking_params[:number_of_guests].to_i)
            room_booking = Booking.new(
              @booking_params.merge(
                total_price: price,
                user_id: @current_user.id,
                booking_status: "pending"
              )
            )
        
            if room_booking.save
              { success: true, booking_id: room_booking.id }
            else
              { success: false, error_message: "Failed to create booking" }
            end
          end
        
          private
        
          def calculate_total_price(room, duration_id, number_of_guests)
            room_price = room.room_price
            total_days = Duration.find(duration_id.to_i).number_of_days
            # debugger
            total_price = (room_price) * number_of_guests * total_days
            total_price
          end
    end
end
