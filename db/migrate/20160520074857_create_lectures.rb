class CreateLectures < ActiveRecord::Migration
  def self.up
    create_table :lectures do |t|
      t.string :name
      t.string :description
      t.references :course
      
      t.timestamps
    end
  end

  def self.down
    drop_table :lectures
  end
end