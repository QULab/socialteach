class CreateLectures < ActiveRecord::Migration
  def change
    create_table :lectures do |t|
      t.string :name
      t.string :description
      t.references :course, index: true

      t.timestamps null: false
    end
    add_foreign_key :lectures, :courses
  end
end
