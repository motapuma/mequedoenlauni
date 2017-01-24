class AddSubjectToMultipleOptionQuestions < ActiveRecord::Migration
  def change
  	add_column :multiple_option_questions, :subject, :integer
  end
end
