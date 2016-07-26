class AddDifficultyToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :difficulty, :integer, null: false, default: 0
  end
end
