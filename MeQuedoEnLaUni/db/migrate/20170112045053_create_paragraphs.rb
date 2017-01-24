class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.text :paragraph
      t.text :post_paragraph

      t.timestamps
    end
  end
end
