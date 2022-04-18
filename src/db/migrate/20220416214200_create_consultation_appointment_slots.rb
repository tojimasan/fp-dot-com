class CreateConsultationAppointmentSlots < ActiveRecord::Migration[6.1]
  def change
    create_table :consultation_appointment_slots do |t|
      t.references :client, null: true, foreign_key: true
      t.references :financial_planner, null: false, foreign_key: true
      t.integer :status, limit: 1
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
