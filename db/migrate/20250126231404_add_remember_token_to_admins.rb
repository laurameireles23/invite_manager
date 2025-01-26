class AddRememberTokenToAdmins < ActiveRecord::Migration[7.2]
  def change
    add_column :admins, :remember_created_at, :datetime
  end
end
