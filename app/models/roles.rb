class Roles < ActiveRecord::Base
  has_many :users, through: :restaurant_user_roles
  has_many :restaurants, through: :restaurant_user_roles
  has_many :restaurant_user_roles
end
