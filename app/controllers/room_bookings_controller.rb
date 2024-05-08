class RoomBookingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        if current_user && current_user.customer
            room = AvailableRoom.find_by(id: booking_params[:available_room_id])
            debugger
            number_of_rooms = booking_params[:number_of_rooms].to_i
            duration_id = booking_params[:duration_id]
            number_of_guests = booking_params[:number_of_guests].to_i
              price = calculate_total_price(room, duration_id, number_of_guests)
              session[:booking_data] = {
                room_id: room.id,
                number_of_rooms: number_of_rooms,
                duration_id: duration_id,
                number_of_guests: number_of_guests,
                total_price: price
              }
              if price > 0  # Proceed to payment only if the price is greater than zero
                  redirect_to new_payment_path
              end
        else
            # session[:booking_form_data] = params[:room_booking]
            redirect_to new_user_session_path, notice: "Please sign in to continue"
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
        debugger
        total_price = (room_price) * number_of_guests * total_days
        total_price
    end
    def booking_params
        params.require(:room_booking).permit(:available_room_id,:duration_id,:start_date,:number_of_guests,:number_of_rooms)
    end
end
