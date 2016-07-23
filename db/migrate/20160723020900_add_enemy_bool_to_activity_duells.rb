class AddEnemyBoolToActivityDuells < ActiveRecord::Migration
  def change
    add_column :activity_duells, :enemy_bool, :boolean
  end
end
