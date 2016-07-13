class CreateMerits < ActiveRecord::Migration
  def change
    create_table :merits do |t|
      t.string :course
      t.float :points
      t.datetime :earned_at

      t.timestamps null: false
    end
  end
end
