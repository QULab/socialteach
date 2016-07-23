class AddChallengerBoolToActivityDuells < ActiveRecord::Migration
  def change
    add_column :activity_duells, :challenger_bool, :boolean
  end
end
