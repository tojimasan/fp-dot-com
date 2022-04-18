class ConsultationAppointmentSlot < ApplicationRecord
  # 1 → 空きあり
  # 2 → 予約済み
  STATUS_WHITE_LIST = [1, 2]
  
  belongs_to :client, optional: true
  belongs_to :financial_planner

  validates :start_at,
    presence: true,
    start_at: true
  validates :end_at,
    presence: true,
    end_at: true
  validates :status,
    inclusion: { in: STATUS_WHITE_LIST },
    presence: true
end
