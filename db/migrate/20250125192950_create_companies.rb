class CreateCompanies < ActiveRecord::Migration[7.2]
  def change
    create_table :companies, id: :uuid do |t|
      t.string :name
      t.string :cnpj
      t.jsonb :address

      t.timestamps
    end
  end
end
