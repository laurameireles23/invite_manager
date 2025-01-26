class CnpjValidator < ActiveModel::Validator
  def validate(record)
    return if record.cnpj.blank?

    cnpj = Cnpj.new(record.cnpj)

    record.errors.add(:cnpj, "não é válido") unless cnpj.valid?
  end
end
