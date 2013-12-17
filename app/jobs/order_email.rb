class OrderEmail
  @queue = :order_email

  def self.perform(user_email, order_id)
    puts "hello"
  end

end
