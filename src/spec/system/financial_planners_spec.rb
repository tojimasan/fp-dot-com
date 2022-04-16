require 'rails_helper'

RSpec.describe "FinancialPlanners", type: :system do
  before do
    @financial_planner = FactoryBot.create(:financial_planner)
  end

  context 'ファイナンシャルプランナーの新規登録ができる時' do
    it '正しい情報を入力すればファイナンシャルプランナーの新規登録ができ、詳細ページが表示される' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへ遷移するボタンが表示されていること
      expect(page).to have_content('新規登録')
      # ファイナンシャルプランナー新規登録ページへ遷移
      visit new_financial_planner_path
      # ファイナンシャルプランナー情報を入力する
      fill_in 'Name', with: @financial_planner.name
      # 登録ボタンを押すとファイナンシャルプランナーモデルのカウントが1上がること
      expect { click_on('登録')}.to change { FinancialPlanner.count }.by(1)
      # 作成したファイナンシャルプランナーのページが表示されること
      visit financial_planner_path(@financial_planner)
      # 新規登録ページやログインページへ遷移するボタンが表示されていないこと
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
end
