class AddUserToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :owner_id, :bigint
    add_index :events, :owner_id # This line is optional but recommended for performance reasons
  end
end
