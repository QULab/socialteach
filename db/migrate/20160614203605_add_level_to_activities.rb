class AddLevelToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :level, index: true
    add_foreign_key :activities, :levels
  end
end
