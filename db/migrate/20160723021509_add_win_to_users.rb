class AddWinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :win, :integer
  end
end
