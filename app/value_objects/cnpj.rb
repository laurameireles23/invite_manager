require "cpf_cnpj"

class Cnpj
  def initialize(number)
    @number = number.to_s.gsub(/[^0-9]/, "")
  end

  def valid?
    CNPJ.valid?(@number)
  end

  def formatted
    CNPJ.new(@number).formatted
  end

  def to_s
    @number
  end
end
