module PaymentsManager
    # app/services/payment_processor.rb
class PaymentProcessor
    def initialize(booking_params, current_user)
      @booking = Booking.find(booking_params[:booking_id])
    #   debugger
      @payment_params = booking_params.slice(:first_name, :last_name, :number, :month, :year, :verification_value)
      @current_user = current_user
    end
  
    def process_payment
      credit_card = build_credit_card
  
      if credit_card.valid?
        update_booking_and_send_confirmation
        return true
      else
        { success: false, error_message: "Invalid Card Details, Payment Failed!" }
      end
    end
  
    private
  
    def build_credit_card
      ActiveMerchant::Billing::CreditCard.new(@payment_params)
    end
  
    def update_booking_and_send_confirmation
      @booking.update(booking_status: 'success')
      @booking.available_room.update(availability: @booking.available_room.availability - 1)
    end
  end
  
end