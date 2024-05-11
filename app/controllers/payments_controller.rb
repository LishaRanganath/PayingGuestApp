require 'active_merchant/billing/rails'
# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  def new
    
      @booking = Booking.find_by(id: params[:booking_id])
  end

  def create
      @booking = Booking.find(params[:booking_id])
      
      credit_card = ActiveMerchant::Billing::CreditCard.new(
        first_name: params[:first_name],
        last_name: params[:last_name],
        number: params[:card_number],
        month: params[:card_month],
        year: params[:card_year],
        verification_value: params[:card_cvv]
        )
      debugger
      if credit_card.valid?
        # Initialize Active Merchant gateway (e.g., for Authorize.Net)
        # gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
        #   login: 'sk_test_51PDsj9SHw1sh6agxhWX7VV7wGE2eSiLc9uUN2IHgmRbnJnV0wQSuR6GD7MMXysNgqFJoxVZOfk49DqdQdu46LR7A00QEaKw4t5',
        #   password: ''
        # )

        # # Process the payment
        # response = gateway.purchase(@booking.total_price * 100, credit_card, ip: request.remote_ip)
        # debugger
        # if response.success?
          # Payment successful
          update_booking_payment_status(@booking, 'success')
          @booking.available_room.update(availability: @booking.available_room.availability - 1)
          redirect_to root_path, notice: 'Payment successful!'
        else
          # Payment failed
          redirect_to root_path, notice: "Invalid Card Details, Payment Failed!"
      end
  end

  private

  def update_booking_payment_status(booking, status)
    booking.update(booking_status: status)
  end
  def has_pending_payments?(user)
    user.bookings.exists?(booking_status: 'pending') # Assuming 'pending' is the status for unpaid bookings
  end
end
