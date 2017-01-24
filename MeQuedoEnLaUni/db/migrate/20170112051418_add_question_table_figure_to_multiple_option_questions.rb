class AddQuestionTableFigureToMultipleOptionQuestions < ActiveRecord::Migration
  def change
    add_reference :multiple_option_questions, :question_table_figure, index: true
  end
end
