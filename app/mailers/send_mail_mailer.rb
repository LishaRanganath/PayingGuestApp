class SendMailMailer < ApplicationMailer
    default from: 'lishar2002@gmail.com'

    def booking_confirmation_mail
        @user=params[:user]
        @booking = params[:booking] 
        mail(to: current_user.email, subject: "Your booking is confirmed")

    end
end
