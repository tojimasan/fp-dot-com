require 'rails_helper'

RSpec.describe "Clients", type: :system do
  before do
    @client = FactoryBot.create(:client)
  end

  context 'クライアントの新規登録ができる時' do
    it '正しい情報を入力すればクライアントの新規登録ができ、詳細ページが表示される' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンが表示されていること
      expect(page).to have_content('新規登録')
      # クライアント新規登録ページへ遷移
      visit new_client_path
      # クライアント情報を入力する
      fill_in 'Name', with: @client.name
      # 登録ボタンを押すとクライアントモデルのカウントが1上がること
      expect { click_on('登録')}.to change { Client.count }.by(1)
      # 作成したクライアントのページが表示されること
      visit client_path(@client)
      # 新規登録ページやログインページへ遷移するボタンが表示されていないこと
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
end
