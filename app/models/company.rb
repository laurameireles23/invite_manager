require "cpf_cnpj"

class Company < ApplicationRecord
  has_many :invitations, dependent: :destroy

  validates :name, :street, :number, :neighborhood, :city, :state, presence: true
  validates :cnpj, presence: true, uniqueness: true
  validates_with CnpjValidator

  def decorate
    CompanyDecorator.new(self)
  end
end
