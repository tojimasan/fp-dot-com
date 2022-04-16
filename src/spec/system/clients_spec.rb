require 'rails_helper'

RSpec.describe "Clients", type: :system do
  before do
    @client = FactoryBot.create(:client)
  end

  context 'クライアントの新規登録ができる時' do
    it '正しい情報を入力すればクライアントの新規登録ができ、詳細ページが表示される' do
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_client_path
      fill_in 'Name', with: @client.name
      expect { click_on('登録')}.to change { Client.count }.by(1)
      # 新規登録された結果、ログアウトボタンが表示される
      expect(page).to have_content("ログアウト")
    end
  end

  context 'クライアントの新規登録ができない時' do
    it '名前が入力されていない場合' do
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_client_path
      fill_in 'Name', with: ''
      expect { click_on('登録')}.to change { Client.count }.by(0)
      expect(current_path).to eq new_client_path
    end
  end

  context 'ログインができること' do
    it 'ログイン後、クライアント詳細ページに遷移していること' do
      log_in(@client)
      expect(current_path).to eq client_path(@client)
      expect(page).to have_content(@client.name)
      expect(page).to have_content("ログアウト")
    end
  end

  context 'ログインできないこと' do
    it "名前が入力されていない場合" do
      visit login_path
      fill_in 'Name', with: ''
      click_button "ログイン"
      expect(current_path).to eq login_path
    end
  end

  context 'ログアウトした場合' do
    before do
      log_in(@client)
      delete logout_path
    end

    it 'セッション情報が削除されること' do
      expect(session[:client_id]).to eq nil
    end
  end
end
