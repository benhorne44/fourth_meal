class Role < ActiveRecord::Base
  has_many :users, through: :jobs
  has_many :restaurants, through: :jobs
  has_many :jobs
end
