class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :level
      t.integer :level_pass

      t.timestamps null: false
    end
  end
end
