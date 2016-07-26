class AddDifficultyToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :difficulty, :integer, null: false, default: 0
  end

  Activity.find_each do |act|
    unless act.difficulty.present?
      act.update_attributes(:difficulty => 0)
    end
  end
end
