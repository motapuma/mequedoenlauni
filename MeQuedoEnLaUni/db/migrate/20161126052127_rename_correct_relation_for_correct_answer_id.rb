class RenameCorrectRelationForCorrectAnswerId < ActiveRecord::Migration
  def change
  	rename_column :multiple_option_questions, :correct_answer, :correct_answer_id
  end
end
