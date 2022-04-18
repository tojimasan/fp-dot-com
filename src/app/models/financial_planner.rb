class FinancialPlanner < ApplicationRecord
    has_many :consultation_appointment_slots
    validates :name, presence: true
end
