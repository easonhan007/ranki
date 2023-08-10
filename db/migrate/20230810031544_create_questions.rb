class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :date_of_occurrence
      t.text :content

      t.timestamps
    end
  end
end
