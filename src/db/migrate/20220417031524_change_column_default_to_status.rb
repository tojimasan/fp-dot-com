class ChangeColumnDefaultToStatus < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:consultation_appointment_slots, :status, 1)
  end
end
