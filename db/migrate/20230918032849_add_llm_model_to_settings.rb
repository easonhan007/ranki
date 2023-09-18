class AddLlmModelToSettings < ActiveRecord::Migration[7.0]
  def change
    add_column :settings, :llm_model, :string, default: 'gpt-3.5-turbo'
  end
end
