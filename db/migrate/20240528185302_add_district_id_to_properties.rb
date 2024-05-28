class AddDistrictIdToProperties < ActiveRecord::Migration[7.1]
  def change
    add_reference :properties, :district, null: false, foreign_key: true
  end
end
