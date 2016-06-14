class AddShortnameToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :shortname, :text
  end
end
