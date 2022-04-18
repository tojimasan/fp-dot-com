require 'rails_helper'

RSpec.describe "FinancialPlanners", type: :system do
  before do
    @financial_planner = FactoryBot.create(:financial_planner)
  end

  context 'ファイナンシャルプランナーの新規登録ができる時' do
    it '正しい情報を入力すればファイナンシャルプランナーの新規登録ができ、詳細ページが表示される' do
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_financial_planner_path
      fill_in 'Name', with: @financial_planner.name
      expect { click_on('登録')}.to change { FinancialPlanner.count }.by(1)
      # 新規登録された結果、予約一覧が表示される
      expect(page).to have_content("予約一覧")
    end
  end

  context 'ファイナンシャルプランナーの新規登録ができない時' do
    it '名前が入力されていない場合' do
      visit root_path
      expect(page).to have_content('新規登録')
      visit new_financial_planner_path
      fill_in 'Name', with: ''
      expect { click_on('登録')}.to change { FinancialPlanner.count }.by(0)
      expect(current_path).to eq financial_planners_path
    end
  end

  context 'ログインができること' do
    it 'ログイン後、ファイナンシャルプランナー詳細ページに遷移していること' do
      log_in(@financial_planner)
      expect(current_path).to eq financial_planner_path(@financial_planner)
      expect(page).to have_content(@financial_planner.name)
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
      log_in(@financial_planner)
      delete logout_path
    end

    it 'セッション情報が削除されること' do
      expect(session[:financial_planner_id]).to eq nil
    end
  end
end
