class CreateMultipleChoiceQuestions < ActiveRecord::Migration
  def change
    create_table :multiple_choice_questions do |t|
      t.text :text
      t.references :questionnaire, index: true

      t.timestamps null: false
    end
  end
end
