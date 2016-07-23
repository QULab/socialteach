class AddMasterToActivityDuells < ActiveRecord::Migration
  def change
    add_column :activity_duells, :master, :boolean
  end
end
