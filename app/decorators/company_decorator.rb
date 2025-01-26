class CompanyDecorator < SimpleDelegator
  attr_reader :company

  def initialize(company)
    @company = company
  end

  def formatted_cnpj
    Cnpj.new(company.cnpj).formatted
  end
end
