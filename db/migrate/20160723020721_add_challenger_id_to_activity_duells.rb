class AddChallengerIdToActivityDuells < ActiveRecord::Migration
  def change
    add_column :activity_duells, :challenger_id, :integer
  end
end
