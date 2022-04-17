class AddIndexToCasStartAt < ActiveRecord::Migration[6.1]
  def change
    add_index :consultation_appointment_slots, [:start_at], :unique =>  true
  end
end
