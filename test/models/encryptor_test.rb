require_relative "../test_helper"

class EncryptorTest < ActiveSupport::TestCase
    
  test "it obscures input data" do
    email = "bob@example.com"
    timestamp = Time.now
    response = Encryptor.obscure_details(email, timestamp)
    expected = Digest::MD5.hexdigest("#{email} #{timestamp.to_s}")
    assert_equal expected, response
  end

end
