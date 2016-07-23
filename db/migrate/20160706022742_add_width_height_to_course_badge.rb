class AddWidthHeightToCourseBadge < ActiveRecord::Migration
  def change
    add_column :course_badges, :width, :integer
    add_column :course_badges, :height, :integer
  end
end
