module UsersHelper

  def owned_restaurants(user)
    owner_jobs = user.jobs.select {|job| job.role_id == 1}
    restaurant_ids = owner_jobs.map(&:restaurant_id)
    restaurant_ids.collect {|id| Restaurant.find(id)}
  end

end
