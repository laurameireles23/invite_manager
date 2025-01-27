class InvitationsController < ApplicationController
  before_action :set_invitation, only: [ :show, :edit, :update, :destroy ]

  def index
    @invitations = InvitationsQuery.new(Invitation.all, filter_params, current_admin).call
  end

  def show; end

  def new
    @invitation = Invitation.new
  end

  def create
    params_with_admin = invitation_params.merge(admin: current_admin)
    result = CreateService.new(Invitation, params_with_admin).call

    if result.success?
      redirect_to invitations_path, notice: "Convite criado com sucesso."
    else
      @invitation = result.record
      render :new
    end
  end

  def edit; end

  def update
    result = UpdateService.new(@invitation, invitation_params).call

    if result.success?
      redirect_to invitations_path, notice: "Convite atualizado com sucesso."
    else
      @invitation = result.record
      render :edit
    end
  end

  def destroy
    result = DestroyService.new(@invitation).call

    if result.success?
      redirect_to invitations_path, notice: "Convite excluído com sucesso."
    else
      redirect_to invitations_path, alert: "Erro ao excluir o convite."
    end
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:name, :email, :company_id, :status, :disable_at)
  end

  def filter_params
    params.permit(:name, :company_id, :start_date, :end_date).to_h.compact_blank
  end
end
