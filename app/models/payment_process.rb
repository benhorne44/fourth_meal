class PaymentProcess

  def self.process(amount, stripe_token)
    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => stripe_token
    )
    begin
      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
      )
    rescue Stripe::CardError => e
      flash[:error] = e.message
      false
    else
      true
    end
  end

end
