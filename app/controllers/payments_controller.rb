require 'active_merchant/billing/rails'
require 'prawn'
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
    pdf = Prawn::Document.new
    pdf.text "Invoice for Booking ##{@booking.id}"
    send_data pdf.render, filename: "invoice_#{@booking.id}.pdf", type: 'application/pdf' 

  end


  private

  def update_booking_payment_status(booking, status)
    booking.update(booking_status: status)
  end
  def has_pending_payments?(user)
    user.bookings.exists?(booking_status: 'pending') # Assuming 'pending' is the status for unpaid bookings
  end
end
