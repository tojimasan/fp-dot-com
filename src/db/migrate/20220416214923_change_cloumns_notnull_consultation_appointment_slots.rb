class ChangeCloumnsNotnullConsultationAppointmentSlots < ActiveRecord::Migration[6.1]
  def change
    change_column_null :consultation_appointment_slots, :status, false
    change_column_null :consultation_appointment_slots, :start_at, false
    change_column_null :consultation_appointment_slots, :end_at, false
  end
end
