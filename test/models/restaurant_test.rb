require_relative "../test_helper"

class RestaurantTest < ActiveSupport::TestCase
   test "a resturant is inactive by defualt" do
     restaurant = Restaurant.create

     refute restaurant.active
   end

   test "a restaurant is unpublished by default" do
     restaurant = Restaurant.create

     refute restaurant.published
   end
end
