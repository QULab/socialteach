class AddPointsToActivityStatus < ActiveRecord::Migration
  def change
    add_reference :activity_statuses, :learningpoints, index: true
    add_foreign_key :activity_statuses, :learningpoints
    add_reference :activity_statuses, :levelpoints, index: true
    add_foreign_key :activity_statuses, :levelpoints
  end
end
