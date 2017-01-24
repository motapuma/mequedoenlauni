class RenameAnswerAndQuestionTable < ActiveRecord::Migration
  def change
  	rename_table :questions, :multiple_option_questions 
  	rename_table :answers,  :multiple_option_answers
  end
end
