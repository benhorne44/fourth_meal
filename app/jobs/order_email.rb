class OrderEmail
  @queue = :order_email

  def self.perform(email, order_id)
    UserMailer.order_email(email, order_id).deliver
  end

end
