class BookingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @complaints = Booking.where.not(complaints: nil)
    end

    def show
        # debugger
        @bookings = Booking.where(user_id: params[:id])
        if current_user && current_user.owner
            @pg_buildings = current_user.owner.pg_buildings
            
        end
    end

    def complaints
            @booking = Booking.find_by(id: params[:id])
            
            if @booking.update(complaints: booking_params[:complaints])
                debugger
                # @booking.notify_owner_of_complaint
                redirect_to root_path, notice: "Feedback sent successfully"
            else
                redirect_to root_path, notice: "Failed to send feedback"
            end
    end
    def create
        # debugger
        if current_user && current_user.role == "user"
            room = AvailableRoom.find_by(id: booking_params[:available_room_id])
            # debugger
            number_of_rooms = booking_params[:number_of_rooms].to_i
            duration_id = booking_params[:duration_id]
            number_of_guests = booking_params[:number_of_guests].to_i

            if room.present? && room.availability >= number_of_rooms
              price = calculate_total_price(room, duration_id, number_of_guests)
              room_booking = Booking.new(
                booking_params.merge(
                    total_price: price,
                    user_id: current_user.id  # Set customer_id to current user's ID
                    )
                )
                # debugger
                if room_booking.save
                    room.update(availability: room.availability - number_of_rooms)
                    redirect_to root_path, notice: "Room booked successfully"
                end
            else
                redirect_to root_path, notice: "Room is not available"
            end
        else
            redirect_to new_registration_path, notice: "Login to Book"
        end
    end

    def calculate_price
        room = AvailableRoom.find_by(id: params[:available_room_id])
        duration_id = params[:duration_id]
        number_of_guests = params[:number_of_guests].to_i

        # Perform price calculation (replace this with your actual logic)
        price = calculate_total_price(room, duration_id, number_of_guests)

        # Return price as JSON response
        render json: { price: price }

    end

    private

    def calculate_total_price(room,duration_id,number_of_guests)
        room_price = room.room_price
        total_days = Duration.find(duration_id.to_i).number_of_days
        # debugger
        total_price = (room_price) * number_of_guests * total_days
        total_price
    end
    def booking_params
        params.require(:booking).permit(:available_room_id,:duration_id,:start_date,:number_of_guests,:number_of_rooms,:complaints)
    end
end