module StatusManageable
  extend ActiveSupport::Concern

  included do
    before_save :set_disable_at_if_cancelled
  end

  private

  def set_disable_at_if_cancelled
    if status_changed? && status == "cancelled"
      self.disable_at = Time.current
    end
  end
end
