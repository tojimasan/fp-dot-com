require 'rails_helper'

RSpec.describe "ConsultationAppointmentSlots", type: :system do
  describe '新規作成' do
    before do
      @financial_planner = FactoryBot.create(:financial_planner)
      log_in(@financial_planner)
      visit new_consultation_appointment_slot_path
    end

    # 成功
    context '平日の10:00 ~ 18:00で作成した場合' do
      it '1件作成される' do
        expect(page).to have_content('予約枠登録')
        fill_in 'consultation_appointment_slot_start_at', with: '2022-04-20T10:00:00'
        expect { click_on('作成') }.to change { ConsultationAppointmentSlot.count }.by(1)
        expect(current_path).to eq financial_planner_path(@financial_planner)
        expect(page).to have_content('予約枠を作成しました')
      end
    end

    context '土曜日の11:00 ~ 15:00で作成した場合' do
      it '1件作成される' do
        expect(page).to have_content('予約枠登録')
        fill_in 'consultation_appointment_slot_start_at', with: '2022-04-16T11:00:00'
        expect { click_on('作成') }.to change { ConsultationAppointmentSlot.count }.by(1)
        expect(current_path).to eq financial_planner_path(@financial_planner)
        expect(page).to have_content('予約枠を作成しました')
      end
    end

    # 失敗
    context '同じ時間に予約を作成している場合' do
      before do
        fill_in 'consultation_appointment_slot_start_at', with: '2022-04-20T10:00:00'
        click_button "作成"
      end

      it '失敗すること' do
        visit new_consultation_appointment_slot_path
        expect(page).to have_content('予約枠登録')
        fill_in 'consultation_appointment_slot_start_at', with: '2022-04-20T10:00:00'
        expect { click_on('作成') }.to change { ConsultationAppointmentSlot.count }.by(0)
        expect(current_path).to eq new_consultation_appointment_slot_path
        expect(page).to have_content('同じ時間に予約枠を作成済みです')
      end
    end

    context '平日の10:00 ~ 18:00以外で作成した場合' do
      it '失敗すること' do
        expect(page).to have_content('予約枠登録')
        fill_in 'consultation_appointment_slot_start_at', with: '2022-04-20T19:00:00'
        expect { click_on('作成') }.to change { ConsultationAppointmentSlot.count }.by(0)
        expect(current_path).to eq consultation_appointment_slots_path
        expect(page).to have_content('Start at 平日の予約枠設定時間は10:00 ~ 18:00です')
      end
    end
    
    context '土曜日の11:00 ~ 15:00以外で作成した場合' do
      it '失敗すること' do
        expect(page).to have_content('予約枠登録')
        fill_in 'consultation_appointment_slot_start_at', with: '2022-04-16T19:00:00'
        expect { click_on('作成') }.to change { ConsultationAppointmentSlot.count }.by(0)
        expect(current_path).to eq consultation_appointment_slots_path
        expect(page).to have_content('Start at 土曜日の予約枠設定時間は11:00 ~ 15:00です')
      end
    end
    
    context '日曜日で作成した場合' do
      it '失敗すること' do
        expect(page).to have_content('予約枠登録')
        fill_in 'consultation_appointment_slot_start_at', with: '2022-04-17T19:00:00'
        expect { click_on('作成') }.to change { ConsultationAppointmentSlot.count }.by(0)
        expect(current_path).to eq consultation_appointment_slots_path
        expect(page).to have_content('Start at 日曜日に予約枠は作成不可です')
      end
    end
  end
  
  describe '新規予約登録' do
    # クライアントユーザーが行う
    before do
      @consultation_appointment_slot = FactoryBot.create(:consultation_appointment_slot, status: 1)
      @client = FactoryBot.create(:client)
      log_in(@client)
      visit edit_consultation_appointment_slot_path(@consultation_appointment_slot)
    end

    context '予約状態が空きの枠を予約した場合' do
      it '成功すること' do
        click_button '予約する'
        expect(page).to have_content('予約しました')
      end
    end
  end
end
