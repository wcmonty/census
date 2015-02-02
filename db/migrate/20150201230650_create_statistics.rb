class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.references :analyzed_field, index: true
      t.string :name
      t.float :value

      t.timestamps null: false
    end
    add_foreign_key :statistics, :analyzed_fields
  end
end
