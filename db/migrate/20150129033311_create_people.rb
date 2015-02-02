class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :gender
      t.integer :height
      t.integer :weight

      t.timestamps null: false
    end
  end
end
