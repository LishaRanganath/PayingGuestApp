class RoomBookingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        if current_user && current_user.customer
            room_type_id = booking_params[:room_type_id]
            category_id = booking_params[:category_id]
            number_of_rooms = booking_params[:number_of_rooms].to_i
            duration_id = booking_params[:duration_id]
            number_of_guests = booking_params[:number_of_guests].to_i
            room_booking = RoomBooking.new(booking_params.merge(customer_id: current_user.customer.id))
            room_available = AvailableRoom.find_by(room_type_id: room_type_id, category_id: category_id)
  
            if room_available.present? && room_available.availability >= number_of_rooms
              price = calculate_total_price(room_type_id, category_id, duration_id, number_of_guests)
              room_booking = RoomBooking.new(
                booking_params.merge(
                    total_price: price,
                    customer_id: current_user.customer.id  # Set customer_id to current user's ID
                    )
                )
                if room_booking.save
                    room_available.update(availability: room_available.availability - number_of_rooms)
                    redirect_to root_path, notice: "Room booked successfully"
                else
                    redirect_to root_path, notice: "Unable to book room"
                end
            else
                redirect_to root_path, notice: "Room is not available"
            end
        else
            session[:booking_form_data] = params[:room_booking]
            redirect_to new_user_session_path, notice: "Please sign in to continue"
        end
      end
      
    def calculate_price
        room_type_id = params[:room_type_id]
        category_id = params[:category_id]
        duration_id = params[:duration_id]
        number_of_guests = params[:number_of_guests].to_i
        
        # Perform price calculation (replace this with your actual logic)
        price = calculate_total_price(room_type_id, category_id, duration_id, number_of_guests)
        # debugger
        # Return price as JSON response
        render json: { price: price }

    end

    private

    def calculate_total_price(room_type_id,category_id,duration_id,number_of_guests)
        room_type_price = RoomType.find(room_type_id.to_i).price
        category_price = Category.find(category_id.to_i).price
        total_days = Duration.find(duration_id.to_i).number_of_days
        # debugger
        total_price = (room_type_price + category_price) * number_of_guests * total_days
        total_price
    end
    def booking_params
        params.require(:room_booking).permit(:room_type_id,:category_id,:duration_id,:start_date,:number_of_guests,:number_of_rooms)
    end
end
