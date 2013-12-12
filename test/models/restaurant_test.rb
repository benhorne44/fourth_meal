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

   test "a restaurant can return it's owner" do
     user = FactoryGirl.create(:user)
     role = FactoryGirl.create(:role)
     restaurant = FactoryGirl.create(:restaurant)
     job = FactoryGirl.create(:job)
     user.jobs << job
     role.jobs << job
     restaurant.jobs << job
     assert_equal [user], restaurant.owners
   end
end
