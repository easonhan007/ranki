class CreateImportRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :import_records do |t|
      t.text :csv
      t.references :user, null: false, foreign_key: true
      t.integer :success, default: 0

      t.timestamps
    end
  end
end
