class Invitation < ApplicationRecord
  include StatusManageable

  belongs_to :company
  belongs_to :admin

  validates :name, :email, :status, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum :status, {
    pending: "pending",
    accepted: "accepted",
    rejected: "rejected",
    cancelled: "cancelled"
  }

  def status_label
    {
      "pending" => "Pendente",
      "accepted" => "Aceito",
      "rejected" => "Rejeitado",
      "cancelled" => "Cancelado"
    }[status]
  end
end
