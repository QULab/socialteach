class AddTierToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :tier, :int
  end
end
