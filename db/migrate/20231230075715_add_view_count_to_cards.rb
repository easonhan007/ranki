class AddViewCountToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :view_count, :integer, default: 0
  end
end
