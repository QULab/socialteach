class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :mc_question, index: true
      t.text :text

      t.timestamps null: false
    end
    add_foreign_key :answers, :mc_questions end
end
