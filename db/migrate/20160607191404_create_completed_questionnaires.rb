class CreateCompletedQuestionnaires < ActiveRecord::Migration
  def change
    create_table :completed_questionnaires do |t|
      t.references :questionnaire, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :completed_questionnaires, :questionnaires
    add_foreign_key :completed_questionnaires, :users
  end
end
