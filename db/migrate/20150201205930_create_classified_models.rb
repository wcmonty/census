class CreateClassifiedModels < ActiveRecord::Migration
  def change
    create_table :classified_models do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
