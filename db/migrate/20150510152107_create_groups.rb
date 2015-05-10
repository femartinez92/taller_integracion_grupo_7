class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :username
      t.string :password

      t.timestamps null: false
    end
  end
end
