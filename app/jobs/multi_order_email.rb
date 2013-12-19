class MultiOrderEmail

  @queue = :multi_order_email

  def self.perform(email, order_ids)
    UserMailer.multi_order_email(email, order_ids).deliver
  end

end
