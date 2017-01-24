class RenameIndexForMultipleAnswerAndQuestion < ActiveRecord::Migration
  def change
  	rename_column :multiple_option_answers, :question_id, :multiple_option_question_id
  	rename_column :multiple_option_questions, :correct_answer_id, :correct_answer
  end
end
