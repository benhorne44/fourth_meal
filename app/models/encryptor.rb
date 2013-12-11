class Encryptor

  def self.obscure_details(a, b)
    Digest::MD5.hexdigest("#{a.to_s} #{b.to_s}")
  end

end
