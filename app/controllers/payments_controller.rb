class PaymentsController < ApplicationController
  def new
    @booking_data = session[:booking_data] || {}
    # @payment = Payment.new
  end

  def create
    gateway = ActiveMerchant::Billing::StripeGateway.new(
      login: 'sk_test_51PDsj9SHw1sh6agxhWX7VV7wGE2eSiLc9uUN2IHgmRbnJnV0wQSuR6GD7MMXysNgqFJoxVZOfk49DqdQdu46LR7A00QEaKw4t5',
      password: ''
    )

    # Replace this with actual payment amount and credit card details
    amount = 1000  # Replace with actual amount in cents
    credit_card = ActiveMerchant::Billing::CreditCard.new(
      number: '4242424242424242',  # Replace with actual credit card number
      month: '01',  # Replace with actual expiration month (e.g., '01' for January)
      year: '2025',  # Replace with actual expiration year
      verification_value: '123'  # Replace with actual CVV
    )

    response = gateway.purchase(amount, credit_card)

    if response.success?
      create_room_booking(params[:room_booking])
      redirect_to root_path, notice: "Room booked successfully"
    else
      redirect_to root_path, notice: "Payment failed"
    end
  end
end
