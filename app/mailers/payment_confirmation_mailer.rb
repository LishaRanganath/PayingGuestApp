class PaymentConfirmationMailer < ApplicationMailer
    default from: 'lissrang123@gmail.com'

    def payment_confirmation_email
        @user = params[:user]
        @booking = params[:booking]
        mail(to: @user.email, subject: "Payment Recieved")
    end
end
