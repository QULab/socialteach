class CreateQuestionnaires < ActiveRecord::Migration
  def change
    create_table :questionnaires do |t|
      t.references :qu_container, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
