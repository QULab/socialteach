class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :text
      t.references :multiple_choice_question, index: true

      t.timestamps null: false
    end
  end
end
