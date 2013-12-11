# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant do
    name "Will's Waffles"
    location "123 Denver Street"
    phone_number "123-456-7890"

    after(:create) do |restaurant|
      restaurant.published = true
      restaurant.active = true
      restaurant.save
    end
  end
end
