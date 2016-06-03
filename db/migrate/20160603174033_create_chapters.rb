class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :shortname
      t.string :description
      t.references :course, index: true

      t.timestamps null: false
    end
  end
end
