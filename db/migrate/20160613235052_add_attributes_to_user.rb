class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :userid, :string
  end
end
