class CreateEncryptors < ActiveRecord::Migration
  def change
    create_table :encryptors do |t|

      t.timestamps
    end
  end
end
