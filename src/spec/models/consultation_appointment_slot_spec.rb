require 'rails_helper'

RSpec.describe ConsultationAppointmentSlot, type: :model do
  let!(:consultation_appointment_slot) { FactoryBot.build(:consultation_appointment_slot) }
  # TODO: 「2022-04-17 10:00:00」をlet!で定義する
  #   日付はテストする上で日曜日であることが重要だが、これだと日曜であることがすぐにわからないため

  describe 'attribute: status' do
    context 'when present' do
      # statusが存在している場合は、有効であること
      it 'is valid' do
        consultation_appointment_slot.status = 1
        expect(consultation_appointment_slot).to be_valid
      end
    end

    context 'when blank' do
      # statusが空白の場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.status = ' '
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:status]).to include("can't be blank")
      end
    end

    context 'when empty' do
      # statusが空の場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.status = ''
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:status]).to include("can't be blank")
      end
    end
  
    context 'when nil' do
      # statusが存在していない場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.status = nil
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:status]).to include("can't be blank")
      end
    end
  
    context 'when out of range' do
      # statusが1,2以外の場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.status = 3
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:status]).to include("is not included in the list")
      end
    end
  end


  describe 'attribute: start_at' do
    context 'when present' do
      it 'is valid' do
        expect(consultation_appointment_slot).to be_valid
      end
    end

    context 'when blank' do
      # start_atが空白の場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.start_at = ' '
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:start_at]).to include("can't be blank")
      end
    end

    context 'when empty' do
      # start_atが空の場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.start_at = ''
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:start_at]).to include("can't be blank")
      end
    end
  
    context 'when nil' do
      # start_atが存在していない場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.start_at = nil
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:start_at]).to include("can't be blank")
      end
    end

    context 'when sunday' do
      # start_atが日曜の場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.start_at = "2022-04-17 10:00:00"
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:start_at]).to include("日曜日に予約枠は作成不可です")
      end
    end

    context 'when minutes is not 00 or 30' do
      # start_atが00または、30分以外の場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.start_at = "2022-04-18 10:10:00"
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:start_at]).to include("予約枠の開始時間は毎時0分、または30分です")
      end
    end

    context 'when saturday and hour is not 10 to 14' do
      # start_atが土曜であるかつ、11時から14時でない場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.start_at = "2022-04-16 08:00:00"
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:start_at]).to include("土曜日の予約枠設定時間は11:00 ~ 15:00です")
      end
    end

    context 'when weekday and hour is not 10 to 17' do
      # start_atが平日であるかつ、10時から17時でない場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.start_at = "2022-04-18 08:00:00"
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:start_at]).to include("平日の予約枠設定時間は10:00 ~ 18:00です")
      end
    end
  end


  describe 'attribute: end_at' do
    context 'when present' do
      it 'is valid' do
        expect(consultation_appointment_slot).to be_valid
      end
    end

    context 'when blank' do
      # end_atが空白の場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.end_at = ' '
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:end_at]).to include("can't be blank")
      end
    end

    context 'when empty' do
      # end_atが空の場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.end_at = ''
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:end_at]).to include("can't be blank")
      end
    end
  
    context 'when nil' do
      # end_atが存在していない場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.end_at = nil
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:end_at]).to include("can't be blank")
      end
    end

    context 'when sunday' do
      # start_atが日曜の場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.end_at = "2022-04-17 10:00:00"
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:end_at]).to include("日曜日に予約枠は作成不可です")
      end
    end

    context 'when minutes is not 00 or 30' do
      # end_atが00または、30分以外の場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.end_at = "2022-04-18 10:10:00"
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:end_at]).to include("予約枠の終了時間は毎時0分、または30分です")
      end
    end

    context 'when saturday and hour is not 10 to 14' do
      # end_atが土曜であるかつ、11時から15時でない場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.end_at = "2022-04-16 16:00:00"
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:end_at]).to include("土曜日の予約枠設定時間は11:00 ~ 15:00です")
      end
    end

    context 'when weekday and hour is not 10 to 17' do
      # end_atが平日であるかつ、10時から18時でない場合は、無効であること
      it 'is invalid' do
        consultation_appointment_slot.end_at = "2022-04-18 19:00:00"
        expect(consultation_appointment_slot).to be_invalid
        expect(consultation_appointment_slot.errors[:end_at]).to include("平日の予約枠設定時間は10:00 ~ 18:00です")
      end
    end
  end
end
