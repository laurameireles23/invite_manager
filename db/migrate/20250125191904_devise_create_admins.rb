# frozen_string_literal: true

class DeviseCreateAdmins < ActiveRecord::Migration[7.2]
  def change
    create_table :admins do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :password, null: false, default: ""
      t.string :name,              null: false, default: ""

      t.timestamps null: false
    end

    add_index :admins, :email,                unique: true
  end
end
