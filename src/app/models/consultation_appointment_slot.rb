class ConsultationAppointmentSlot < ApplicationRecord
  belongs_to :client
  belongs_to :financial_planner
end
