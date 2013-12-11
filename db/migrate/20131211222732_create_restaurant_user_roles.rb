class CreateRestaurantUserRoles < ActiveRecord::Migration
  def change
    create_table :restaurant_user_roles do |t|
      t.references :user, index: true
      t.references :restaurant, index: true
      t.references :role, index: true

      t.timestamps
    end
  end
end
