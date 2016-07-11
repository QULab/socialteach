class AddCquestionnaireToCquestion < ActiveRecord::Migration
  def change
    add_column :completed_m_questions, :completed_questionnaire_id, :integer
  end
end
