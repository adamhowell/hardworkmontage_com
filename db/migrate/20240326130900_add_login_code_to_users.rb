class AddLoginCodeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :login_code, :string
  end
end
