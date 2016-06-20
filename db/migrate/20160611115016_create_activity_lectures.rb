class CreateActivityLectures < ActiveRecord::Migration
  def change
    create_table :activity_lectures do |t|
      t.text :text, null: false

      t.timestamps null: false
    end
  end
end
