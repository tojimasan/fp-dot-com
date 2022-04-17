class ConsultationAppointmentSlot < ApplicationRecord
  belongs_to :client, optional: true
  belongs_to :financial_planner
  validates :start_at, presence: true
  validates :end_at, presence: true
end
