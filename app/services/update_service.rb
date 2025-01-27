require "ostruct"

class UpdateService
  def initialize(record, params)
    @record = record
    @params = params
  end

  def call
    @record.update(@params) ? OpenStruct.new(success?: true,
record: @record) : OpenStruct.new(success?: false, record: @record)
  end
end
