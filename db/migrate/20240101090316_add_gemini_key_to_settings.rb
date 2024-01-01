class AddGeminiKeyToSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :settings, :gemini_key, :string
  end
end
