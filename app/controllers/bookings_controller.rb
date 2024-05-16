class BookingsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index
        @complaints = Booking.where.not(complaints: nil)
    end

    def show
        @bookings = Booking.where(user_id: params[:id],booking_status: "success")
        if current_user && current_user.owner
            @pg_buildings = current_user.owner.pg_buildings
        end
    end

    def list
        if current_user && current_user.owner
            @pg_buildings = current_user.owner.pg_buildings
        end
    end
    def complaints
            @booking = Booking.find_by(id: params[:id])
            if @booking.has_complaint?
                redirect_to root_path , notice: "You already Have raised a complaint"
            else
                if @booking.update(complaints: booking_params[:complaints])
                    redirect_to root_path, notice: "Feedback sent successfully"
                else
                    redirect_to root_path, notice: "Failed to send feedback"
                end
            end
    end
    def create
        booking_creator = BookingsManager::BookingsCreator.new(current_user, booking_params)
        result = booking_creator.create_booking
    
        if result[:success]
          redirect_to new_payment_path(booking_id: result[:booking_id]), notice: "Please Complete The Payment to Book the Room."
        else
          redirect_to root_path, notice: result[:error_message]
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

    def booking_params
        params.require(:booking).permit(:available_room_id,:duration_id,:start_date,:number_of_guests,:number_of_rooms,:complaints)
    end
end