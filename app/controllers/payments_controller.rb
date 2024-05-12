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
      # debugger
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
          # debugger
          render json: { success: true, download_url: download_invoice_path(@booking.id) } 
        else
          # Payment failed
          redirect_to root_path, notice: "Invalid Card Details, Payment Failed!"
        end
  end

  def download_invoice
    # debugger
    @booking = Booking.find(params[:id])
    # Generate the invoice content (replace this with your actual invoice generation logic)
    pdf = Prawn::Document.new
    pdf.text "Invoice for Booking ##{@booking.id}" # Use @booking.id instead of booking.id
    # invoice_content = "Invoice for booking ID: #{@booking.id}\nAmount: #{@booking.total_price}"

    # Serve the invoice as a downloadable file
    send_data pdf.render, filename: "invoice_#{@booking.id}.pdf", type: 'application/pdf' # Use @booking.id instead of booking.id  end

  end


  private

  def update_booking_payment_status(booking, status)
    booking.update(booking_status: status)
  end
  def has_pending_payments?(user)
    user.bookings.exists?(booking_status: 'pending') # Assuming 'pending' is the status for unpaid bookings
  end
end
