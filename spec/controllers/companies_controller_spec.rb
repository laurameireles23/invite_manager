require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let!(:company) { create(:company) }
  let(:valid_attributes) { attributes_for(:company) }
  let(:invalid_attributes) { attributes_for(:company, :invalid) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      expect(assigns(:companies)).to include(company)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: company.id }
      expect(response).to be_successful
      expect(assigns(:company)).to eq(company)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Company" do
        expect {
          post :create, params: { company: valid_attributes }
        }.to change(Company, :count).by(1)

        expect(response).to redirect_to(companies_path)
        expect(flash[:notice]).to eq("Empresa criada com sucesso.")
      end
    end

    context "with invalid params" do
      it "does not create a new Company" do
        expect {
          post :create, params: { company: invalid_attributes }
        }.not_to change(Company, :count)

        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: company.id }
      expect(response).to be_successful
      expect(assigns(:company)).to eq(company)
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { name: "Empresa Atualizada" } }

      it "updates the requested company" do
        expect(UpdateService).to receive(:new).with(company, new_attributes.stringify_keys).and_call_original

        patch :update, params: { id: company.id, company: new_attributes }
        company.reload

        expect(company.name).to eq("Empresa Atualizada")
        expect(response).to redirect_to(companies_path)
        expect(flash[:notice]).to eq("Empresa atualizada com sucesso.")
      end
    end

    context "with invalid params" do
      it "does not update the company" do
        patch :update, params: { id: company.id, company: invalid_attributes }
        company.reload

        expect(company.name).not_to eq("")
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested company" do
      expect {
        delete :destroy, params: { id: company.id }
      }.to change(Company, :count).by(-1)

      expect(response).to redirect_to(companies_path)
      expect(flash[:notice]).to eq("Empresa foi removida com sucesso.")
    end
  end
end
