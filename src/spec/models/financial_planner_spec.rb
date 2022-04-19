require 'rails_helper'

RSpec.describe FinancialPlanner, type: :model do
  describe 'attribute: name' do
    context '入力されている場合' do
      it '有効であること' do
        financial_planner = FactoryBot.build(:financial_planner)
        expect(financial_planner).to be_valid
      end
    end

    context '空の場合' do
      it 'エラーになること' do
        financial_planner = FactoryBot.build(:financial_planner, name: '')
        financial_planner.valid?
        expect(financial_planner.errors[:name]).to include("can't be blank")
      end
    end

    context 'nilの場合' do
      it 'エラーになること' do
        financial_planner = FactoryBot.build(:financial_planner, name: nil)
        financial_planner.valid?
        expect(financial_planner.errors[:name]).to include("can't be blank")
      end
    end

    context '空文字の場合' do
      it 'エラーになること' do
        financial_planner = FactoryBot.build(:financial_planner, name: ' ')
        financial_planner.valid?
        expect(financial_planner.errors[:name]).to include("can't be blank")
      end
    end
  end

  describe '#consultation_appointment_slots' do
    context '予約されていない枠が複数ある場合' do
      let!(:financial_planner) { create(:financial_planner) }
      let!(:unreserved_slot) { create :consultation_appointment_slot, financial_planner: financial_planner, status: 1 }
      let!(:reserved_slot) { create :consultation_appointment_slot, financial_planner: financial_planner, status: 2 }
      it '件数が返ること' do
        expect(financial_planner.consultation_appointment_slots).to eq [unreserved_slot, reserved_slot]
      end
    end
  end
end
