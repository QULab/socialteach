class CreateActivityDuells < ActiveRecord::Migration
  def change
    create_table :activity_duells do |t|

      t.timestamps null: false
    end
  end
end
