# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  def new
    @booking = Booking.find_by(id: params[:booking_id])
  end

  def create
    @booking = Booking.find_by(id: params[:booking_id])
    # debugger
    payment_processor = PaymentsManager::PaymentProcessor.new(params, current_user)
    result = payment_processor.process_payment

    if result
      PaymentConfirmationMailer.with(user: @current_user, booking: @booking).payment_confirmation_email.deliver_now
      render json: { success: true, download_url: download_invoice_path(@booking.id) }
    else
      redirect_to root_path, notice: result[:error_message]
    end
  end

  def download_invoice
    @booking = Booking.find(params[:id])
    pdf = InvoicePdfGenerator.new(@booking).generate
    send_data pdf.render, filename: "invoice_#{@booking.id}.pdf", type: 'application/pdf' 
  end
end
