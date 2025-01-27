module InvitationsHelper
  def available_statuses_for(invitation)
    statuses = if invitation.new_record?
      %w[pending]
    else
      Invitation.statuses.keys
    end

    statuses.map { |status| [ Invitation.new(status: status).status_label, status ] }
  end

  def can_edit_invitation?(invitation)
    invitation.status != "cancelled"
  end
end
