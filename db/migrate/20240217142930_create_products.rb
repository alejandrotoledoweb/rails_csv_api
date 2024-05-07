class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price, :precision => 8, :scale => 2
      t.string :primary_category
      t.string :second_category
      t.string :model_number
      t.string :upc
      t.string :sku

      t.timestamps
    end
  end
end
