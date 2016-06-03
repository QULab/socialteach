class DropLecturesTable < ActiveRecord::Migration
  def change
      drop_table :lectures, :lessons
  end
end
