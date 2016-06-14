class AddTierToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :tier, :int
  end
end
