class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.references :user, index: true
      t.references :restaurant, index: true
      t.references :role, index: true

      t.timestamps
    end
  end
end
