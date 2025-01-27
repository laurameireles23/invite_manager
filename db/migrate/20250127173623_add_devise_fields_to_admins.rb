class AddDeviseFieldsToAdmins < ActiveRecord::Migration[7.2]
  def change
    add_column :admins, :reset_password_token, :string unless column_exists?(:admins, :reset_password_token)
    add_column :admins, :reset_password_sent_at, :datetime unless column_exists?(:admins, :reset_password_sent_at)
    add_column :admins, :remember_created_at, :datetime unless column_exists?(:admins, :remember_created_at)
    add_column :admins, :sign_in_count, :integer, default: 0, null: false unless column_exists?(:admins, :sign_in_count)
    add_column :admins, :current_sign_in_at, :datetime unless column_exists?(:admins, :current_sign_in_at)
    add_column :admins, :last_sign_in_at, :datetime unless column_exists?(:admins, :last_sign_in_at)
    add_column :admins, :current_sign_in_ip, :string unless column_exists?(:admins, :current_sign_in_ip)
    add_column :admins, :last_sign_in_ip, :string unless column_exists?(:admins, :last_sign_in_ip)

    add_index :admins, :reset_password_token, unique: true unless index_exists?(:admins, :reset_password_token)
  end
end
