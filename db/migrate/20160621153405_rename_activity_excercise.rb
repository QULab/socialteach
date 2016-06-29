class RenameActivityExcercise < ActiveRecord::Migration
  def change
    rename_table :activity_excercises, :activity_exercises
  end
end
