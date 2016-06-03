class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.integer :levelpoints
      t.references :chapter, index: true

      t.timestamps null: false
    end
  end
end
