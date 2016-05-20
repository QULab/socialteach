class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.string :description
      t.references :lecture, index: true

      t.timestamps null: false
    end
    add_foreign_key :lessons, :lectures
  end
end
