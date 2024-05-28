class ChangeDistrictColumnTypeInProperties < ActiveRecord::Migration[7.1]
  def change
    remove_column :properties, :district, :string
  end
end
