require "ostruct"

class CreateService
  def initialize(model, params)
    @model = model
    @params = params
  end

  def call
    record = @model.new(@params)

    record.save ? OpenStruct.new(success?: true, record: record) : OpenStruct.new(success?: false, record: record)
  end
end
