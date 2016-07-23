class AddLoseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lose, :integer
  end
end
