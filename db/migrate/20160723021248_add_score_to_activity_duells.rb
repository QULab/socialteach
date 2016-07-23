class AddScoreToActivityDuells < ActiveRecord::Migration
  def change
    add_column :activity_duells, :score, :integer
  end
end
