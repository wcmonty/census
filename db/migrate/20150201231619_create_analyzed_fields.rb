class CreateAnalyzedFields < ActiveRecord::Migration
  def change
    create_table :analyzed_fields do |t|
      t.references :classification, index: true
      t.string :name

      t.timestamps null: false
    end
    add_foreign_key :analyzed_fields, :classifications
  end
end
