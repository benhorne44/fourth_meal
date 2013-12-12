require 'pry'
class Job < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  belongs_to :role

  def owner
    Role.find(role_id).name == 'owner'
  end

  def self.create_new(restaurant, user, role_name)
    role = Role.where(name: role_name).first
    job = new(user_id: user.id, restaurant_id: restaurant.id, role_id: role.id)
    job.save
    job
  end
end
