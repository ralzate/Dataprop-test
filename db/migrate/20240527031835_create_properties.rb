class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :property_type
      t.decimal :price
      t.string :currency
      t.string :district
      t.string :address
      t.float :area
      t.integer :bedrooms
      t.integer :bathrooms
      t.float :latitude
      t.float :longitude
      t.text :description

      t.timestamps
    end
  end
end
