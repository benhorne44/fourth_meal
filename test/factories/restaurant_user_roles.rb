# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant_user_role do
    user nil
    restaurant nil
    role nil
  end
end
