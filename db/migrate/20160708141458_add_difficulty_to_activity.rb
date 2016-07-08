class AddDifficultyToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :difficulty, :integer
  end
end
