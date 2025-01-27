class CompaniesController < ApplicationController
  before_action :set_company, only: [ :show, :edit, :update, :destroy ]

  def index
    @companies = Company.all
  end

  def show; end

  def new
    @company = Company.new
  end

  def create
    result = CreateService.new(Company, company_params).call

    if result.success?
      redirect_to companies_path, notice: "Empresa criada com sucesso."
    else
      @company = result.record
      render :new
    end
  end

  def edit; end

  def update
    result = UpdateService.new(@company, company_params.to_h).call

    if result.success?
      redirect_to companies_path, notice: "Empresa atualizada com sucesso."
    else
      render :edit
    end
  end

  def destroy
    DestroyService.new(@company).call

    redirect_to companies_path, notice: "Empresa foi removida com sucesso."
  end

  private

  def set_company
    @company = Company.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to companies_path, alert: "Empresa não encontrada."
  end

  def company_params
    params.require(:company).permit(:name, :cnpj, :street, :number, :complement, :neighborhood, :city, :state)
  end
end
