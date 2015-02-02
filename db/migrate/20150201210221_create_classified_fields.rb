class CreateClassifiedFields < ActiveRecord::Migration
  def change
    create_table :classified_fields do |t|
      t.string :name
      t.references :classified_model

      t.timestamps null: false
    end
  end
end
