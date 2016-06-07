class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|

      t.timestamps null: false
    end
  end
end
