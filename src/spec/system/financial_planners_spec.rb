require 'rails_helper'

RSpec.describe "FinancialPlanners", type: :system do
  describe '新規登録' do
    context '正しい情報を入力した場合' do
      financial_planner = FactoryBot.build(:financial_planner)
      it '登録され、詳細ページが表示されること' do
        visit new_financial_planner_path
        expect(page).to have_content('FP登録')
        fill_in 'Name', with: financial_planner.name
        expect { click_on('登録') }.to change { FinancialPlanner.count }.by(1)
        expect(current_path).to eq financial_planner_path(FinancialPlanner.last)
        expect(page).to have_content("#{financial_planner.name}の予約一覧")
        # flashが表示されること
        expect(has_css?('.alert-primary')).to be_truthy
        visit current_path
        expect(has_css?('.alert-primary')).to be_falsy
      end
    end

    context '名前が空の場合' do
      it '登録されないこと' do
        visit new_financial_planner_path
        expect(page).to have_content('FP登録')
        fill_in 'Name', with: ''
        expect { click_on('登録') }.to change { FinancialPlanner.count }.by(0)
        expect(page).to have_content("FP登録")
        expect(page).to have_content("Name can't be blank")
      end
    end

    context '名前がnilの場合' do
      it '登録されないこと' do
        visit new_financial_planner_path
        expect(page).to have_content('FP登録')
        fill_in 'Name', with: nil
        expect { click_on('登録') }.to change { FinancialPlanner.count }.by(0)
        expect(page).to have_content("FP登録")
        expect(page).to have_content("Name can't be blank")
      end
    end

    context '名前が空文字の場合' do
      it '登録されないこと' do
        visit new_financial_planner_path
        expect(page).to have_content('FP登録')
        fill_in 'Name', with: ' '
        expect { click_on('登録') }.to change { FinancialPlanner.count }.by(0)
        expect(page).to have_content("FP登録")
        expect(page).to have_content("Name can't be blank")
      end
    end
  end

  describe 'ログイン' do
    context '正しい情報を入力した場合' do
      # ログインするためにあらかじめFPを作成する
      let!(:financial_planner) { create(:financial_planner) }

      it 'ログインできること' do
        visit login_path
        fill_in 'Name', with: financial_planner.name
        click_button "ログイン"
        expect(current_path).to eq financial_planner_path(financial_planner)
        expect(page).to have_content(financial_planner.name)
        expect(page).to have_content("ログアウト")
        expect(page).to have_content("予約枠を作成")
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
    let!(:financial_planner) { create(:financial_planner) }
    before do
      log_in(financial_planner)
    end

    it 'ルートに戻ること' do
      click_link "ログアウト"
      expect(page).to have_content("ログアウトしました")
    end
  end
end
