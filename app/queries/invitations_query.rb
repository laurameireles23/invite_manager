class InvitationsQuery
  attr_reader :relation, :params, :current_admin

  def initialize(relation = Invitation.all, params = {}, current_admin)
    @relation = relation
    @params = params
    @current_admin = current_admin
  end

  def call
    return base_scope if params.blank?

    base_scope
      .then { |rel| filter_by_name(rel) }
      .then { |rel| filter_by_company(rel) }
      .then { |rel| filter_by_date_range(rel) }
  end

  private

  def base_scope
    relation.where(admin: current_admin)
  end

  def filter_by_name(rel)
    return rel unless params[:name].present?

    rel.where("invitations.name ILIKE ?", "%#{params[:name]}%")
  end

  def filter_by_company(rel)
    return rel unless params[:company_id].present?

    rel.where(company_id: params[:company_id])
  end

  def filter_by_date_range(rel)
    return rel unless params[:start_date].present? && params[:end_date].present?

    start_date = Date.parse(params[:start_date]).beginning_of_day
    end_date = Date.parse(params[:end_date]).end_of_day

    rel.where("created_at BETWEEN ? AND ?", start_date, end_date)
       .where("disable_at IS NULL OR disable_at > ?", start_date)
  end
end
