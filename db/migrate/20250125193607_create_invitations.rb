class CreateInvitations < ActiveRecord::Migration[7.2]
  def change
    create_table :invitations, id: :uuid do |t|
      t.string  :name
      t.string  :email
      t.string :status, default: 'pending', null: false
      t.datetime :disable_at

      t.references :company, type: :uuid, foreign_key: true
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
