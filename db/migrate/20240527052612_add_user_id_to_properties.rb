class AddUserIdToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :user_id, :integer
  end
end
