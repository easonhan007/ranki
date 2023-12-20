class AddGeminiKeyToSettings < ActiveRecord::Migration[7.1]
  def change
    add_column :settings, :gemini_key, :string
  end
end
