class DeleteStartAtUniqIndexFromCas < ActiveRecord::Migration[6.1]
  def change
    remove_index :consultation_appointment_slots, :start_at
  end
end
