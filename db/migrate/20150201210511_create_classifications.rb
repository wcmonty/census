class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.string :name
      t.references :classified_field
      t.float :probability

      t.timestamps null: false
    end
  end
end
