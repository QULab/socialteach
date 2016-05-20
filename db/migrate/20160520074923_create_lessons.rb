class CreateLessons < ActiveRecord::Migration
  def self.up
    create_table :lessons do |t|
      t.string :name
      t.string :description
      t.references :lecture
      
      t.timestamps
    end
  end

  def self.down
    drop_table :lessons
  end
end