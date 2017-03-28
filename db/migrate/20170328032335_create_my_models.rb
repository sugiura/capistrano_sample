class CreateMyModels < ActiveRecord::Migration
  def change
    create_table :my_models do |t|
      t.string :field1
      t.integer :field2
      t.date :field3
      t.boolean :field4

      t.timestamps null: false
    end
  end
end
