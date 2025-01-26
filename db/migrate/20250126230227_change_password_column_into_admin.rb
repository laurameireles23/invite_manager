class ChangePasswordColumnIntoAdmin < ActiveRecord::Migration[7.2]
  def change
    rename_column :admins, :password, :encrypted_password
  end
end
