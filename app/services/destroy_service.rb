require "ostruct"

class DestroyService
  def initialize(record)
    @record = record
  end

  def call
    @record.destroy ? OpenStruct.new(success?: true, record: @record) : OpenStruct.new(success?: false, record: @record)
  end
end
