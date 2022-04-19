require 'rails_helper'

RSpec.describe "Clients", type: :system do
  describe '新規登録' do
    context '正しい情報を入力した場合' do
      client = FactoryBot.build(:client)
      it '登録され、詳細ページが表示されること' do
        visit new_client_path
        expect(page).to have_content('クライアント登録')
        fill_in 'Name', with: client.name
        # クリックしたタイミングで別のレコードを生成している？
        expect { click_on('登録') }.to change { Client.count }.by(1)
        expect(current_path).to eq client_path(Client.last)
        expect(page).to have_content("#{client.name}の予約一覧")
        # flashが表示されること
        expect(has_css?('.alert-primary')).to be_truthy
        visit current_path
        expect(has_css?('.alert-primary')).to be_falsy
      end
    end

    context '名前が空の場合' do
      it '登録されないこと' do
        visit new_client_path
        expect(page).to have_content('クライアント登録')
        fill_in 'Name', with: ''
        expect { click_on('登録') }.to change { Client.count }.by(0)
        expect(page).to have_content("クライアント登録")
        expect(page).to have_content("Name can't be blank")
      end
    end

    context '名前がnilの場合' do
      it '登録されないこと' do
        visit new_client_path
        expect(page).to have_content('クライアント登録')
        fill_in 'Name', with: nil
        expect { click_on('登録') }.to change { Client.count }.by(0)
        expect(page).to have_content("クライアント登録")
        expect(page).to have_content("Name can't be blank")
      end
    end

    context '名前が空文字の場合' do
      it '登録されないこと' do
        visit new_client_path
        expect(page).to have_content('クライアント登録')
        fill_in 'Name', with: ' '
        expect { click_on('登録') }.to change { Client.count }.by(0)
        expect(page).to have_content("クライアント登録")
        expect(page).to have_content("Name can't be blank")
      end
    end
  end

  describe 'ログイン' do
    context '正しい情報を入力した場合' do
      # ログインするためにあらかじめクライアントを作成する
      let!(:client) { create(:client) }

      it 'ログインできること' do
        visit login_path
        fill_in 'Name', with: client.name
        click_button "ログイン"
        expect(current_path).to eq client_path(client)
        expect(page).to have_content(client.name)
        expect(page).to have_content("ログアウト")
        expect(page).to have_content("相談の予約枠を検索")
        expect(page).to have_content("ログインしました")
        visit current_path
        expect(page).not_to have_content("ログインしました")
      end
    end

    context '名前が空の場合' do
      it "ログインできないこと" do
        visit login_path
        fill_in 'Name', with: ''
        click_button "ログイン"
        expect(current_path).to eq login_path
      end
    end

    context '名前がnilの場合' do
      it "ログインできないこと" do
        visit login_path
        fill_in 'Name', with: nil
        click_button "ログイン"
        expect(current_path).to eq login_path
      end
    end

    context '名前が空文字の場合' do
      it "ログインできないこと" do
        visit login_path
        fill_in 'Name', with: ' '
        click_button "ログイン"
        expect(current_path).to eq login_path
      end
    end
  end

  context 'ログアウトした場合' do
    let!(:client) { create(:client) }
    before do
      log_in(client)
    end

    it 'ルートに戻ること' do
      click_link "ログアウト"
      expect(page).to have_content("ログアウトしました")
    end
  end
end
