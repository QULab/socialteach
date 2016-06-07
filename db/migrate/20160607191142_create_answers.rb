class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :multiple_choice_questions, index: true
      t.text :text

      t.timestamps null: false
    end
    add_foreign_key :answers, :multiple_choice_questions
  end
end
