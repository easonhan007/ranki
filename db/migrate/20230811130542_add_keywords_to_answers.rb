class AddKeywordsToAnswers < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :keywords, :text
  end
end
