class CreateQuestionTableFigures < ActiveRecord::Migration
  def change
    create_table :question_table_figures do |t|
      t.text :table_json

      t.timestamps
    end
  end
end
