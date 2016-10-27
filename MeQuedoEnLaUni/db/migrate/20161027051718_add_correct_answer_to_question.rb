class AddCorrectAnswerToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :correct_answer, index: true
  end
end
