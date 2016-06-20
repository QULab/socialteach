class CreateActivityExcercises < ActiveRecord::Migration
  def change
    create_table :activity_excercises do |t|

      t.timestamps null: false
    end
  end
end
