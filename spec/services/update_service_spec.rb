require 'rails_helper'

RSpec.describe UpdateService do
  let!(:company) { create(:company, name: "Empresa Antiga") }
  let(:valid_attributes) { { name: "Empresa Atualizada" } }
  let(:invalid_attributes) { { name: nil } }

  describe "#call" do
    context "when given valid attributes" do
      it "updates the record and returns success" do
        service = UpdateService.new(company, valid_attributes)
        result = service.call

        company.reload
        expect(result.success?).to be true
        expect(company.name).to eq("Empresa Atualizada")
      end
    end

    context "when given invalid attributes" do
      it "does not update the record and returns failure" do
        service = UpdateService.new(company, invalid_attributes)
        result = service.call

        company.reload
        expect(result.success?).to be false
        expect(company.name).to eq("Empresa Antiga")
      end
    end
  end
end
