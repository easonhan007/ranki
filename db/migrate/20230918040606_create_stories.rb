class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.text :words
      t.integer :word_count, default: 5
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
