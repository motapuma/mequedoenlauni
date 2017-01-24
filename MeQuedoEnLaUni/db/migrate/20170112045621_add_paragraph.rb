class AddParagraph < ActiveRecord::Migration
  def change
  	add_reference :multiple_option_questions, :paragraph, index: true
  end
end
