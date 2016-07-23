class AddEnemyIdToActivityDuells < ActiveRecord::Migration
  def change
    add_column :activity_duells, :enemy_id, :integer
  end
end
