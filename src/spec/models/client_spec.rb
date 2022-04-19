require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'attribute: name' do
    context '入力されている場合' do
      it '有効であること' do
        client = FactoryBot.build(:client)
        expect(client).to be_valid
      end
    end

    context '空の場合' do
      it 'エラーになること' do
        client = FactoryBot.build(:client, name: '')
        client.valid?
        expect(client.errors[:name]).to include("can't be blank")
      end
    end

    context 'nilの場合' do
      it 'エラーになること' do
        client = FactoryBot.build(:client, name: nil)
        client.valid?
        expect(client.errors[:name]).to include("can't be blank")
      end
    end

    context '空文字の場合' do
      it 'エラーになること' do
        client = FactoryBot.build(:client, name: ' ')
        client.valid?
        expect(client.errors[:name]).to include("can't be blank")
      end
    end
  end

  describe '#consultation_appointment_slots' do
    context '予約した枠が複数ある場合' do
      let!(:client) { create(:client) }
      let!(:unreserved_slot) { create :consultation_appointment_slot, client: client, status: 1 }
      let!(:reserved_slot) { create :consultation_appointment_slot, client: client, status: 2 }
      it '件数が返ること' do
        expect(client.consultation_appointment_slots).to eq [unreserved_slot, reserved_slot]
      end
    end
  end
end
