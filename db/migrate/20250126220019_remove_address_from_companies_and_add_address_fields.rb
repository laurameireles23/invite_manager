class RemoveAddressFromCompaniesAndAddAddressFields < ActiveRecord::Migration[7.2]
  def change
    remove_column :companies, :address

    add_column :companies, :street, :string
    add_column :companies, :number, :integer
    add_column :companies, :complement, :string
    add_column :companies, :neighborhood, :string
    add_column :companies, :city, :string
    add_column :companies, :state, :string
  end
end
