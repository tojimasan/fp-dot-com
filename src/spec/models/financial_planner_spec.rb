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
end
